import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";

// Connects to data-controller="spotify-auth"
export default class extends Controller {
  // static values = { clientId: String };
  static targets = ['auth', 'genres']

  connect() {
    console.log("This is from Connect Spotify Stimulus");

    let access_token = localStorage.getItem("access_token");

    if (access_token !== null) {
      // console.log("Spotify Account Authozised")
      // console.log(this.authTarget)

      console.log(this.genresTarget)
      // this.genresTarget.classList.remove("d-none")
    } else {
      // this.authTarget.classList.remove("d-none")
    }

    // Check if there's any params in the URL, if yes, will call #handleRedirect() to clean up the URL
    if (window.location.search.length > 0) {
      this.#handleRedirect();
    } else {
      // let access_token = localStorage.getItem("access_token");
    }

    // let client_id = document.querySelector(".spotify-env").dataset.clientId;
    // let client_secret = document.querySelector(".spotify-env").dataset.clientSecret;

    // localStorage.setItem("client_id", client_id);
    // localStorage.setItem("client_secret", client_secret);
  }

  disconnect() {
    // localStorage.removeItem("access_token");
    // localStorage.removeItem("refresh_token");
  }

  // ! (1) An Event Listener for Connecting Spotify API
  linkToSpotify(e) {
    e.preventDefault()
    console.log("This is linkToSpotify");

    this.#requestAuthorization(e);
  }

  // ! (2) Send the App Id, App Secret, and the scope the Spotify API Endpoint to get the Authorization Code
  #requestAuthorization(e) {
    console.log("This is requestAuthorization");

    e.preventDefault(e);

    // Your client id
    let client_id = document.querySelector(".spotify-env").dataset.clientId;

    // Your secret
    let client_secret =
      document.querySelector(".spotify-env").dataset.clientSecret;

    // Your redirect uri
    // let redirect_uri = "https://lfc-sandbox-c15f95ad1922.herokuapp.com/profile";
    let redirect_uri = "http://www.jamwithme.site/profile";

    localStorage.setItem("client_id", client_id);
    localStorage.setItem("client_secret", client_secret);
    localStorage.setItem("redirect_url", redirect_uri);

    // Application requests authorization
    let scope =
      "user-top-read user-follow-read user-read-playback-state user-modify-playback-state";
    let params = new URLSearchParams({
      response_type: "code",
      client_id: client_id,
      scope: scope,
      redirect_uri: redirect_uri,
    });

    let spotifyUrl =
      "https://accounts.spotify.com/authorize?" + params.toString();

    // Direct the Spotify API Authorization Page
    window.location.href = spotifyUrl;
  }

  // ! (3) After Being Redirecting back to Our App from Spotify Authorization Page, Use the Code to Fetch Access Token
  #handleRedirect() {
    let code = this.#getCode();

    this.#fetchAccessToken(code);

    // Your redirect uri
    // let redirect_uri = "https://lfc-sandbox-c15f95ad1922.herokuapp.com/profile";
    // let redirect_uri = "http://localhost:3000/profile";

    let redirect_uri = localStorage.getItem("redirect_url");

    window.history.pushState("", "", redirect_uri);
  }

  // ! (4) Function to Get the Spotify Authorization Code from URL
  #getCode() {
    let code = null;

    const queryString = window.location.search;

    if (queryString.length > 0) {
      const urlParams = new URLSearchParams(queryString);
      code = urlParams.get("code");
    }

    return code;
  }

  // ! (5) Prepare the Fetch Request Body to Spotify Authorization for Getting the Access Token
  #fetchAccessToken(code) {
    let client_id = localStorage.getItem("client_id");
    let client_secret = localStorage.getItem("client_secret");
    let redirect_url = localStorage.getItem("redirect_url");

    let body = "grant_type=authorization_code";
    body += "&code=" + code;
    body += "&redirect_uri=" + encodeURI(redirect_url);
    body += "&client_id=" + client_id;
    body += "&client_secret=" + client_secret;

    this.#callAuthorizationApi(body);
  }

  // ! (6) Make the Fetch Request to Get Spotify Bearer Access Token
  #callAuthorizationApi(body) {
    let client_id = localStorage.getItem("client_id");
    let client_secret = localStorage.getItem("client_secret");

    const TOKEN = "https://accounts.spotify.com/api/token";

    fetch(TOKEN, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Authorization: "Basic " + btoa(client_id + ":" + client_secret),
      },
      body: body,
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);

        if (data.token_type === "Bearer") {
          this.#handleAuthorizationResponse(data);
        }
      })
      .catch((error) => {
        // Handle error
      });
  }

  // ! (7) Save the Access Token and Refresh Once Successfully Getting the Fetch Response from Spotify
  #handleAuthorizationResponse(data) {
    let access_token;
    let refresh_token;

    if (data.access_token != undefined) {
      access_token = data.access_token;
      localStorage.setItem("access_token", access_token);
    }

    if (data.refresh_token != undefined) {
      refresh_token = data.refresh_token;
      localStorage.setItem("refresh_token", refresh_token);
    }
   this.getTopArtists
    // this.connect();
  }

  // ! (8) Use Access Token to Get the User's Top Artists
  getTopArtists() {
    console.log("This is getTopArtists Stimulus");

    let access_token = localStorage.getItem("access_token");

    fetch("https://api.spotify.com/v1/me/top/artists?limit=5", {
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer " + access_token,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);

        const topArtists = document.querySelector(".top-artists");

        data.items.forEach((artist) => {
          topArtists.insertAdjacentHTML(
            "beforeend",
            `<p><a href="${artist.external_urls.spotify}" target="_blank">${artist.name}</a></p>`
          );
        });
      });
  }

  getTopGenres() {
    console.log("This is callApi Stimulus");

    let access_token = localStorage.getItem("access_token");

    fetch("https://api.spotify.com/v1/me/top/artists", {
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer " + access_token,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);

        let genres = [];

        data.items.forEach((artist) => {
          genres = genres.concat(artist.genres);
        });

        let topFiveGenres = this.#topNMostFrequentElements(genres, 5);

        console.log(topFiveGenres);

        if (topFiveGenres.length >= 5) {
          console.log("Deleting current top genres");

          // const topGenres = document.querySelector(".top-genres-list");
          // topGenres.innerHTML = "";
          const topGenres = document.querySelector(".genres-list");
          topGenres.innerHTML = "";

          fetch("/genres/destroy_all", {
            method: "DELETE",
            headers: {
              "X-CSRF-Token": Rails.csrfToken(),
            },
          })
            .then((response) => {
              if (!response.ok) {
                throw new Error("Network response was not ok");
              }
              return response;
            })
            .then((data) => {
              console.log(data);
            })
            .catch((error) => {
              console.error("Error creating genre instance:", error);
            });

          topFiveGenres.forEach((genre) => {
            // this.saveTopGenres(genre);

            fetch("/top_genres", {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": Rails.csrfToken(),
                // You might need to include other headers, like authorization headers
              },
              body: JSON.stringify({ genre: genre }), // Assuming your genre data is an object
            })
              .then((response) => {
                if (!response.ok) {
                  throw new Error("Network response was not ok");
                }
                console.log(response);
              })
              .then((data) => {
                console.log("Genre instance created:", data);

                // const topGenres = document.querySelector(".top-genres-list");
                const topGenres = document.querySelector(".genres-list");

                topGenres.insertAdjacentHTML("beforeend", `<p>${genre}</p>`);
              })
              .catch((error) => {
                console.error("Error creating genre instance:", error);
              });
          });
        }
      })
      .catch((error) => {
        // Handle error
      });

      let redirectLink = "http://www.jamwithme.site/profile"

      const currentUrl = window.location.href;
      console.log(currentUrl)

      if (currentUrl !==  redirectLink) {
        window.location.href = redirectLink;
      }
  }

  getTopTracks() {
    console.log("This is getTopTracks Stimulus");

    let access_token = localStorage.getItem("access_token");

    fetch("https://api.spotify.com/v1/me/top/tracks?limit=5", {
      // method: method,
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer " + access_token,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);

        let tracks = [];
        let spotify_ref = []

        const topTracks = document.querySelector(".top-tracks");

        fetch("/tracks/destroy_all", {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": Rails.csrfToken(),
          },
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response;
          })
          .then((data) => {
            console.log(data);
          })
          .catch((error) => {
            console.error("Error creating track instance:", error);
          });

        data.items.forEach((track) => {
          tracks = tracks.concat(track.name);
          spotify_ref = spotify_ref.concat(track.id);

            topTracks.insertAdjacentHTML(
              "beforeend",
              `<p><div class="d-flex"><div data-action="click->spotify-auth#playTrack" data-track-id="${track.id}" class="btn btn-primary">${track.name}</div><div data-action="click->spotify-auth#pauseTrack" class="btn btn-danger mx-3">Stop</div></div></p>`
            );

          fetch("/top_tracks", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": Rails.csrfToken(),
              // You might need to include other headers, like authorization headers
            },
            body: JSON.stringify({ track: track.name, spotify_ref: track.id }), // Assuming your genre data is an object
          })
            .then((response) => {
              if (!response.ok) {
                throw new Error("Network response was not ok");
              }
              console.log(response);
            })
            .then((data) => {
              console.log("Genre instance created:", data);

              // const topGenres = document.querySelector(".top-genres-list");
              const topTracks = document.querySelector(".tracks-list");

              topTracks.insertAdjacentHTML("beforeend", `<p>${track}</p>`);
            })
            .catch((error) => {
              console.error("Error creating genre instance:", error);
            });

        });

        console.log(tracks);
        console.log(spotify_ref);

        const topTracksDiv = document.querySelector(".tracks-list");
        topTracksDiv.innerHTML = "";
        })
        .catch((error) => {
          // Handle error
        });

        let redirectLink = "http://www.jamwithme.site/profile"

        const currentUrl = window.location.href;
        console.log(currentUrl)

        if (currentUrl !==  redirectLink) {
          window.location.href = redirectLink;
        }
  }

  playTrack(e) {
    console.log("This is playTrack Stimulus");

    const trackId = e.currentTarget.dataset.trackId;
    console.log(trackId);

    let access_token = localStorage.getItem("access_token");

    this.fetchValidDeviceId(access_token, trackId);
  }

  pauseTrack() {
    console.log("This is pauseTrack Stimulus");

    let access_token = localStorage.getItem("access_token");
    let deviceId = localStorage.getItem("device");
    console.log(deviceId);

    const pauseUrl = "https://api.spotify.com/v1/me/player/pause";
    // const pauseUrl = `https://api.spotify.com/v1/me/player/pause/${deviceId}`;

    fetch(pauseUrl, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer " + access_token,
      },
    })
      .then((response) => response.json())
      .then((data) => console.log(data))
      .catch((error) => {
        // Handle error
      });
  }

  async fetchValidDeviceId(access_token, trackId) {
    const playUrl = "https://api.spotify.com/v1/me/player";
    let body;

    while (true) {
      try {
        const response = await fetch(
          "https://api.spotify.com/v1/me/player/devices",
          {
            headers: {
              "Content-Type": "application/json",
              Authorization: "Bearer " + access_token,
            },
          }
        );

        const data = await response.json();
        console.log("This is fetching Spotify device");
        console.log(data);

        const smartPhoneDevice = data.devices.find(
          (device) => device.type === "Smartphone"
        );

        // if (smartPhoneDevice && smartPhoneDevice.is_active) {
        if (smartPhoneDevice) {
          const smartPhoneId = smartPhoneDevice.id;
          console.log(smartPhoneId);
          localStorage.setItem("device", smartPhoneId);

          // const playUrl = "https://api.spotify.com/v1/me/player";
          body = {
            device_ids: [smartPhoneId],
            play: true,
          };

          // Perform the 'play' action or any other relevant action here.
          // For example, you can use another fetch to play music on the device.

          break; // Exit the loop if a valid device ID is found.
        } else {
          console.log("No valid smartphone device found. Retrying...");
        }
      } catch (error) {
        console.error("An error occurred:", error);
      }

      // Wait for a short duration before trying again.
      await new Promise((resolve) => setTimeout(resolve, 5000)); // Wait for 5 seconds
    }

    this.playMusicAsync(playUrl, access_token, body);

    console.log(trackId);

    const playTrackUrl = "https://api.spotify.com/v1/me/player/play";
    const bodyTrack = {
      uris: [`spotify:track:${trackId}`],
    };

    fetch(playTrackUrl, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer " + access_token,
      },
      body: JSON.stringify(bodyTrack),
    })
      .then((response) => response.json())
      .then((data) => console.log(data))
      .catch((error) => {
        // Handle error
      });
  }

  async playMusicAsync(playUrl, access_token, body) {
    try {
      const response = await fetch(playUrl, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + access_token,
        },
        body: JSON.stringify(body),
      });

      if (!response.ok) {
        throw new Error("Request failed with status: " + response.status);
      }

      const data = await response.json();
      console.log(data);
    } catch (error) {
      // Handle error
      // console.error(error);
    }
  }

  async saveTopGenres(genre) {
    try {
      const response = await fetch("/top_genres", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": Rails.csrfToken(),
          // You might need to include other headers, like authorization headers
        },
        body: JSON.stringify({ genre: genre }), // Assuming your genre data is an object
      })

      if (!response.ok) {
        throw new Error("Request failed with status: " + response.status);
      }

      const data = await response.json();
      console.log(data);

      console.log("Genre instance created:", data);

      // const topGenres = document.querySelector(".top-genres-list");
      const topGenres = document.querySelector(".genres-list");
      topGenres.insertAdjacentHTML("beforeend", `<p>${genre}</p>`);
    } catch (error) {
      console.log(error)
    }
  }

    #topNMostFrequentElements(array, n) {
      const frequencyMap = new Map();

      // Count the frequency of each element
      array.forEach((element) => {
        frequencyMap.set(element, (frequencyMap.get(element) || 0) + 1);
      });

      // Sort elements by frequency in descending order
      const sortedElements = Array.from(frequencyMap.entries()).sort(
        (a, b) => b[1] - a[1]
      );

      // Get the top N most frequent elements
      const topN = sortedElements.slice(0, n).map((entry) => entry[0]);

      return topN;
    }

  // submitForm() {
  //   const form = document.querySelector('form[data-controller="spotify-auth"]');
  //   form.submit();
  // }
}
