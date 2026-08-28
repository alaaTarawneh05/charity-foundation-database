CREATE DATABASE Foundation;
USE Foundation;


--         table 1 : 

create table Donors(
 Donor_ID int(10) primary key ,
 Fname varchar(15) NOT NULL,
 Lname varchar(15) NOT NULL,
 career_info varchar(255) NOT NULL,
 Email varchar(50) NOT NULL UNIQUE,
 city varchar(15) NOT NULL,
 street varchar(15) NOT NULL,
 buildingNum varchar(15) NOT NULL
)Engine = InnoDB;

insert into Donors ( Donor_ID,Fname,Lname,career_info,Email,city,street,buildingNum) values
(1,'Ahmad','saleh','CEO of samsunge', 'Ahmad@1234.com' ,'Amman','mecca street', '2A' ),
(2,'Ayah','Manaseer','An electrical engineer working at Mercedes ', 'Ayah@1234.com' ,'Amman','merj al-hamam ', '4c'),
(3,'Sura','Anoka','Director of a sales company for JT', 'Sura@1234.com' ,'madaba','kingHussain', '8j'),
(4,'Alaa','Tarawneh','Data scientist at Ciscoe', 'Alaa@1234.com' ,'Amman','mouzib alawi', '7n'      ),
(5,'leen','ahmad','manager of the Rosary Sisters School', 'leen@1234.com' ,'jerash','kayani street', '3A');



--           table 2:

create table Donors_phone(
 Donor_ID int(10) default 0 ,
 phoneNum varchar(20) ,
 primary key(Donor_ID,phoneNum),
 constraint donor_phoneFK foreign key (Donor_ID) references Donors(Donor_ID) ON UPDATE CASCADE ON DELETE cascade
)Engine = InnoDB;


insert into Donors_phone (Donor_ID,phoneNum) values
(1,'+962-795402766'),
(2,'+962-875622336'),
(3,'+962-798563247'),
(4,'+962-775267897'),
(5,'+962-884236984'),
(5,'+962-897752422');


--            table 3:

create table Student(
 Student_ID int(10) primary key,
 Fname varchar(15) NOT NULL,
 Lname varchar(15) NOT NULL,
 needs_info varchar(255) NOT NULL,
 Email varchar(50) NOT NULL UNIQUE,
 city varchar(15) NOT NULL,
 Age int(10) not null check(age <=30 )

)Engine = InnoDB;

insert into Student(Student_ID, Fname, Lname, needs_info, Email, city, Age) values

(1, 'Ali', 'tareq', 'Financial aid for tuition', 'ali123@gmail.com', 'zarqa', 20),
(2, 'dana', 'mohammad', 'Scholarship for books', 'dana123@gmail.com', 'madaba', 22),
(3, 'lana', 'hakem', 'Housing assistance', 'lana123@gmail.com', 'madaba', 25),
(4, 'zaid', 'ahmad', 'Transportation allowance', 'zaid123@gmail.com', 'irbid', 28),
(5, 'mohammad', 'raed', 'Meal plan support', 'Mohammad123@gmail.com', 'irbid', 30);




--       table 4:
create table Event(
 EventID int(10) primary key ,
 location varchar(15) not null,
 EventDate date not null,
 Event_description varchar(255) NOT NULL
)Engine = InnoDB;

insert into Event (EventID,location,EventDate,Event_description) values 
(11, 'Amman', '2020-05-15', 'Charity gala to support underprivileged students in Jordan'),
(22, 'Irbid', '2021-12-20', 'Fundraising event for school supplies in northern Jordan'),
(33, 'Aqaba', '2022-06-05', 'Marathon to raise funds for student scholarships'),
(44, 'Zarqa', '2023-01-10', 'Workshop on education and career development');

select * from Event;



--          table 5:

create table Donation(
 DonationID int(10) primary key ,
 Amount decimal(10,3) not null,
 DonationDate date not null,
 payment_method varchar(15) not null,
 Donor_ID int(10) not null,
 EventID int(10) not null,
 constraint d1_fk foreign key(Donor_ID) REFERENCES Donors(Donor_ID) ON UPDATE CASCADE ON DELETE CASCADE , 
 constraint d2_fk foreign key(EventID) references Event(EventID) ON UPDATE CASCADE ON DELETE no action
)Engine = InnoDB;

insert into Donation (DonationID, Amount, DonationDate, payment_method, Donor_ID, EventID) values

(11, 100, '2023-10-15', 'Credit Card', 1, 11),  -- donor 1 donated at Event 1
(12, 500, '2023-11-20', 'Cash', 4, 22),       
(13, 300, '2023-12-05', 'Bank Transfer', 3, 33), 
(14, 100, '2023-12-05', 'Bank Transfer', 2, 33), 
(15, 200, '2024-01-10', 'Credit Card', 4, 44); 




--            table 6:

create table student_donation(
  DonationID int(10) not null,
  Student_ID int(10) not null,
  primary key( DonationID ,Student_ID ),
 constraint s1_fk foreign key(DonationID) REFERENCES Donation(DonationID) ON UPDATE CASCADE ON DELETE Restrict, 
 constraint s2_fk foreign key(Student_ID) REFERENCES Student(Student_ID) ON UPDATE CASCADE ON DELETE CASCADE

  
)Engine = InnoDB;
select * from student_donation;



insert into student_donation (DonationID, Student_ID) values
(11, 1), --   Donation 1 is allocated to Student 1 
(11, 2), 
(11, 3), 
(11, 4),  
(12, 2), 
(12, 3), 
(13, 1);


--           table 7:

create table Engagement(
 Donor_ID int(10) not null,
 EventID int(10) not null,
 primary key(Donor_ID , EventID ),
 constraint e1_fk foreign key(Donor_ID) REFERENCES Donors(Donor_ID) ON UPDATE CASCADE ON DELETE CASCADE,
 constraint e2_fk foreign key(EventID) REFERENCES Event(EventID) ON UPDATE CASCADE ON DELETE CASCADE


)Engine = InnoDB;


insert into Engagement (Donor_ID,EventID) values
(1, 11),
(2, 22),
(3, 33),
(4, 44),
(5, 11),
(5, 33),
(4, 33),
(1, 44),
(3, 22),
(2, 44);




                               --             views                  

-- view 1 : donor contribution 
create view donorContribution  as 
select d.Donor_ID, d.Fname, d.Lname, sum(do.Amount) as total_Amount
from Donors d join Donation do 
on d.Donor_ID = do.Donor_ID 
group by d.Donor_ID;






--  view 2  all_participants

create view all_participants as
select e.EventID, e.EventDate, e.location, d.Donor_ID, d.Fname, d.Lname
from Engagement eng 
join Donors d on eng.Donor_ID = d.Donor_ID
join Event e on eng.EventID = e.EventID;




-- view 2 student_receiving
create view student_receiving as
select s.Student_ID, s.Fname, s.Lname, s.needs_info, sum(do.Amount) as total_receivings
from Student as s 
join student_donation sn on s.Student_ID = sn.Student_ID
join Donation as do on sn.DonationID= do.DonationID
group by s.Student_ID;



-- view 4 : event_total_donations
create view event_total_donations as
select e.EventID, e.location,  e.EventDate,  sum(do.Amount) as total_Amount
from Event as e 
join Donation as do on e.EventID = do.EventID 
group by e.EventID;



--                                          procedures

-- procedure 1 : student information:

DELIMITER //

create procedure get_student_info( in std_id int )
begin 
SELECT * FROM Student where Student_ID = std_id;
end//
DELIMITER ;

call get_student_info(1);

call get_student_info(1);

-- procedure 2 : get_event's_details

DELIMITER //
create procedure get_event_details(in event_id int)
begin 
select * from Event
where EventID = event_id;
end//
DELIMITER ;

select * from student_receiving;


-- call get_event_details(11);

-- procedure 3 : get the total donations from one donor

DELIMITER //
create procedure donations_by_donors( in do_id int)
begin 
select sum(Amount) from Donation
where Donor_ID = do_id;

end //
DELIMITER ;
call donations_by_donors(4);

-- procedure 4 : get students from a specific city

DELIMITER //
create procedure student_by_City ( in city_name varchar(10))
begin 
select Fname, Lname, needs_info from Student
where city_name = city;
end //
DELIMITER ;

-- call student_by_City('zarqa');
 
 
 --                                                users :

-- creating users
-- user 1 : admin who has all privilages
/* create user Admin identified by 'abc@admin_xx';
grant all privileges on Foundation to Admin with grant option ; 
grant select , insert , update , delete on Foundation to Admin  ; 
*/


create user ADMIN  identified by 'admin123@**' ;
grant all privileges on foundation to ADMIN;





-- user 2 : donor's data manager 
create user donor_info_manager identified by 'abc@ddon_xx';
grant select on foundation.donors to donor_info_manager; 
grant select on foundation.Donation to donor_info_manager; 
grant insert on foundation.Donation to donor_info_manager; 

-- revoke





-- a procedure to be used in user 3
DELIMITER //
Create procedure get_Student_don_info( in std_id int )
begin 
select s.Student_ID,
        s.Fname,
        s.Lname,
        s.needs_info,
        s.Email,
        s.city,
        s.Age,
      sum(d.Amount) as total_donations
      
      from Student s
      left join student_donation sd on s.Student_ID = sd.Student_ID
      left join donation d on sd.DonationID = d.DonationID
      where s.Student_ID = std_id 
      group by s.Student_ID;
      
end //
DELIMITER ; 

-- user 3:  studentUSER 
create user studentUSER identified by 'abcd@678hn$';
grant execute on procedure get_Student_don_info to studentUSER;





-- create a procedure for event user
DELIMITER // 
Create procedure view_donorName_byEvent( in eventid int )
begin 
select d.Fname , d.Fname
from Donors d join engagement e on d.Donor_ID=e.Donor_ID
where e.EventID = eventid;
end //
DELIMITER ;



-- user 4 :  eventUser
create user eventUser identified by '1234@77event';
grant select on foundation.event to eventUser ;
grant execute on procedure view_donorName_byEvent to eventUser;
grant insert on foundation.engagement to eventUser;



-- user 5 : procedureUSER
create user procedureUSER identified by 'pro1234@_*';
grant execute on procedure get_student_info to procedureUSER;
grant execute on procedure get_event_details to procedureUSER;
grant execute on procedure donations_by_donors to procedureUSER;
grant execute on procedure student_by_City to procedureUSER;



-- testing : 8.1 :

-- uniqueness of primary key 
insert into Donors values (1,'test', 'test','test','test','test','test','test');

-- null values :
insert into Donors values (null,'test', 'test','test','test','test','test','test');

-- test foreign key
-- Non-existent PK
insert into donors_phone values ( 15, ' +962-795402697' );

-- on delete cascade 
delete from Student 
WHERE Student_ID = 5;

select * from  student_donation where Student_ID = 5;


-- on delete restrict 

delete from donation where donationID = 13; 

--  unique constraint
insert into Student values (6,'test','test','test','ali123@gmail.com', 'amman',25);

-- not null
insert into Donors ( Donor_ID,Fname,Lname,career_info,Email,city,street,buildingNum) values
(89,'alaa','ali','doctor','aa@123', NULL, 'ali street', '8u');

-- check constraint

insert into Student(Student_ID, Fname, Lname, needs_info, Email, city, Age) values

(90, 'Ali', 'tareq', 'Financial aid for tuition', 'ali123@gmail.com', 'zarqa', 35);






--                                         output validation 8.2


-- 1 select statement to return donations along donors and event details
select dn.DonationID, d.Donor_ID, d.Fname, e.EventID, e.location, e.EventDate from donation dn 
join donors d on d.Donor_ID=dn.Donor_ID
join event e on e.EventID=dn.EventID;



-- 2 select students who live in madaba
select * from student where city = 'madaba';


-- 3 
insert into event values(55, 'Amman', '2025-12-10', 'Educational workshop');
select * from event where EventID=55;


-- 4
update student 
set needs_info = 'transportation assistance'
where student_ID = 3;
select needs_info from student where student_ID = 3;



-- 5
select e.location, sum(d.Amount) TotalDonation from Event e
join Donation d on e.EventID = D.EventID
group by e.location;


-- 6
call student_by_City('Zarqa');




--  7
select * from donorcontribution 
where Donor_ID = 2;


ALTER USER 'root'@'localhost' IDENTIFIED BY 'Alaa8888';
FLUSH PRIVILEGES;

 
