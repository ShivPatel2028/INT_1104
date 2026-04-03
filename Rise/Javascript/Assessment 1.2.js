function isPrime(value) {
    const num = Number(value);
    if (!Number.isInteger(num) || num < 2) {
        return false;
    }

    if (num === 2 || num === 3) {
        return true;
    }

    if (num % 2 === 0) {
        return false;
    }

    const limit = Math.floor(Math.sqrt(num));
    for (let i = 3; i <= limit; i += 2) {
        if (num % i === 0) {
            return false;
        }
    }

    return true;
}

function humanizedPrimeCheck(value) {
    const num = Number(value);
    if (Number.isNaN(num)) {
        return `${value} is not a valid number.`;
    }

    if (isPrime(num)) {
        return `${num} is a prime number.`;
    }

    return `${num} is not a prime number.`;
}

// Example usage:
console.log(humanizedPrimeCheck(2));
console.log(humanizedPrimeCheck(15));
console.log(humanizedPrimeCheck('17'));