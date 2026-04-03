
class EventEmitter {
  constructor() {
    this.events = {};
  }

  on(event, callback) {
    if (!this.events[event]) {
      this.events[event] = [];
    }
    this.events[event].push(callback);
  }

  emit(event, ...args) {
    if (this.events[event]) {
      this.events[event].forEach(callback => callback(...args));
    }
  }

  off(event, callback) {
    if (this.events[event]) {
      this.events[event] = this.events[event].filter(cb => cb !== callback);
    }
  }
}

const emitter = new EventEmitter();


function greet(name) {
  console.log(`Hello, ${name}!`);
}

function bye(name) {
  console.log(`Goodbye, ${name}!`);
}


emitter.on("userEvent", greet);
emitter.on("userEvent", bye);


emitter.emit("userEvent", "Shiv");


emitter.off("userEvent", bye);


emitter.emit("userEvent", "Shiv");