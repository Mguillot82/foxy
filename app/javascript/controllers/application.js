import { Application } from "@hotwired/stimulus";
import FriendCardController from "../controllers/friend_card_controller";

const application = Application.start();
application.register("friend-card", FriendCardController);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
