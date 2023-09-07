import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"


// Connects to data-controller="message-notifications"
export default class extends Controller {
  async connect() {
    console.log("hello from message notifications");
    const chatroomsData = await this.getChatroomsData();
    const currentUser = chatroomsData.user_id;
    console.log(chatroomsData);
    chatroomsData.chatrooms.forEach((chatroomId) => {
      this.connectChatrooms(chatroomId, currentUser);
    })
  }

  async getChatroomsData() {
    try {
      const response = await fetch("/user/chatrooms");
      const data = await response.json();
      console.log(data);
      return data;
    } catch (error) {
      console.log(error)
    }
  }

  connectChatrooms(id, currentUser) {
    const consumer = createConsumer()
    const subscription = consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: id },
      { received: data => this.createMessageNotifications(data, id, currentUser) }
    )

    this.subscriptions.push(subscription);

    console.log(`Subscribed to the chatroom with the id ${id}`);
  }

  constructor() {
    super(...arguments);
    this.subscriptions = [];
  }

  createMessageNotifications(data, id, currentUser) {
    const htmlMessage = data.message;
    const tempHtml = document.createElement("div");
    tempHtml.innerHTML = htmlMessage;

    // console.log(tempHtml);

    const username = tempHtml.querySelector("strong").innerText;
    // console.log(username);

    const messageContent = tempHtml.querySelector("p").innerText;
    // console.log(messageContent);

    // console.log(id);

    if (data.sender_id !== currentUser) {
      const messageHtml = `<a href="/chatrooms/${id}"><div class="message-notifications"><p>${username}:</p><p>${messageContent}</p></div></a>`;
      this.element.insertAdjacentHTML("beforeend", messageHtml);
    }
  }

  async disconnect() {
      // Unsubscribe from all stored subscriptions
    this.subscriptions.forEach((subscription) => {
      subscription.unsubscribe();
    });
  }
  }
