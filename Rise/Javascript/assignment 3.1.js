const employees = [
  { name: "Amit", salary: 50000 },
  { name: "Neha", salary: 35000 },
  { name: "Raj", salary: 80000 },
  { name: "Priya", salary: 45000 }
];

const processedEmployees = employees
  // Filter salary > 40000
  .filter(emp => emp.salary > 40000)

  // Increase salary & add level
  .map(emp => {
    const updatedSalary = emp.salary * 1.1; // 10% increase

    return {
      ...emp,
      salary: updatedSalary,
      level: updatedSalary >= 70000 ? "Senior" : "Mid"
    };
  });

console.log(processedEmployees);