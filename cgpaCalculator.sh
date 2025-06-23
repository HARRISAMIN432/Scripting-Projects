#!/bin/bash

echo "=== CGPA Calculator ==="
read -p "Enter number of entries (e.g., number of semesters): " n

total_ch=0
total_weighted_gpa=0

for ((i=1; i<=n; i++))
do
  echo ""
  echo "Entry #$i"
  read -p "Enter Credit Hours (CH): " ch
  read -p "Enter GPA: " gpa

  weighted=$(echo "$ch * $gpa" | bc -l)
  total_ch=$(echo "$total_ch + $ch" | bc)
  total_weighted_gpa=$(echo "$total_weighted_gpa + $weighted" | bc -l)
done

cgpa=$(echo "scale=3; $total_weighted_gpa / $total_ch" | bc -l)

echo ""
echo "📊 Total Credit Hours: $total_ch"
echo "🎓 Your CGPA is: $cgpa"
