import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from "stimulus-use"

export default class extends Controller {
  static targets = [ "menuItems", "menu", "menuIcon" ]
  collapsed = false;

  toggleSideMenu() {
    this.collapsed = !this.collapsed;
    this.menuItemsTarget.className = this.collapsed ? "text-gray-400 transition duration-300" : "hidden";
    this.menuTarget.className = this.collapsed ? '' : 'h-15';
    this.menuIconTarget.className.baseVal = this.collapsed ? 'w-3 h-3 transition duration-300 rotate-90' : 'w-3 h-3 transition duration-300 rotate-180';
  }

  toggleTopMenu() {
    useClickOutside(this);

    this.collapsed = !this.collapsed;
    this.menuItemsTarget.className = this.collapsed ? "absolute right-10 w-40 top-11 border border-gray-300 z-20" : "hidden";
    this.menuIconTarget.className.baseVal = this.collapsed ? 'w-3 h-3 transition duration-300 rotate-90' : 'w-3 h-3 transition duration-300 rotate-180';
  }

  clickOutside() {
    this.toggleTopMenu();
  }
}
