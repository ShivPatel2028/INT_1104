1.

const students = [
  { name: "Amit", marks: [80, 75, 85] },
  { name: "Neha", marks: [60, 55, 50] },
  { name: "Raj", marks: [40, 45, 35] }
];

const studentReport = students.map(student => {
  // Calculate average
  const average =
    student.marks.reduce((sum, mark) => sum + mark, 0) /
    student.marks.length;

  // Assign result
  let result;
  if (average >= 75) {
    result = "Distinction";
  } else if (average >= 50) {
    result = "Pass";
  } else {
    result = "Fail";
  }

  // Return new object with average & result
  return {
    ...student,
    average: average,
    result: result
  };
});

console.log(studentReport);

