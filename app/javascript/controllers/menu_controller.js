import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menuItems", "menu", "menuIcon" ]
  collapsed = false;

  toggle() {
    this.collapsed = !this.collapsed;
    this.menuItemsTarget.className = this.collapsed ? "text-gray-400 transition duration-300" : "text-gray-400 hidden transition duration-300";
    this.menuTarget.className = this.collapsed ? '' : 'h-15';
    this.menuIconTarget.className.baseVal = this.collapsed ? 'w-3 h-3 transition duration-300 rotate-90' : 'w-3 h-3 transition duration-300 rotate-180';
  }
}
