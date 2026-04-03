function debounce(fn, wait) {
  let timer = null;
  return function(...args) {
    const context = this;
    if (timer) {
      clearTimeout(timer);
    }
    timer = setTimeout(() => {
      timer = null;
      fn.apply(context, args);
    }, wait);
  };
}

const logMessage = debounce((message) => {
  console.log(message);
}, 1000);   