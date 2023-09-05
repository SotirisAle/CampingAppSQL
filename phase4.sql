/**total number of bookings in return for payment*/

SELECT payMethod, count(bookCode)
  FROM payment, booking
WHERE payment.paycode=booking.paycode
GROUP BY paymethod

/**employee who cleared the most reservations*/

SELECT staffname, staffsurname, count(bookcode)
  FROM staff,booking
WHERE staff.staffNo=booking.staffno
GROUP BY Staffname, StaffSurname
HAVING count(bookcode) =
(select max (z)
  from (SELECT staffname, staffsurname, count(bookcode) AS z
        FROM staff,booking
      WHERE staff.staffNo=booking.staffno
      GROUP BY Staffname, StaffSurname) as t)

/**total number of bookings containing only category "A" seats*/

select count(booking.bookcode)
  from booking
    WHERE NOT EXISTS (select *
  from rental, emplacement
    where booking.bookcode = rental.bookcode and
      rental.campcode=emplacement.campcode and
      rental.empno=emplacement.empno and catcode !='A' )

/**total value of bookings*/

SELECT campName, SUM ( (datediff(day, startdt, endDt) + 1) * noPers * unitcost)
    FROM rental, emplacement, category, camping
  WHERE Rental.campCode=emplacement.campcode and
        rental.empno=emplacement.empno and
          emplacement.catcode=category.catCode and
          emplacement.campcode=camping.campcode
GROUP BY campName
