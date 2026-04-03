
function throttle(func, delay) {
    let flag = true;

    return function (...args) {
        if (flag) {
            func.apply(this, args);
            flag = false;

            setTimeout(() => {
                flag = true;
            }, delay);
        }
    };
}


function handleClick() {
    console.log("Button clicked at:", new Date().toLocaleTimeString());
}


const throttledClick = throttle(handleClick, 2000);


setInterval(() => {
    throttledClick();
}, 500);