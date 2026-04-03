function reverseString(str) {
  if (typeof str !== 'string') return '';
  let result = '';
  for (let i = str.length - 1; i >= 0; i--) {
    result += str[i];
  }
  return result;
}

console.log(reverseString('hello world')); // dlrow olleh
