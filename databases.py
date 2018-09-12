from faker import Faker
import random
import csv
from datetime import date
from datetime import timedelta
from datetime import datetime
from dateutil.parser import parse

fake = Faker()

def generateSalary():
    return round(random.randint(2500000,5000000)/100,2)

modified_date = 0

print(fake.date_between_dates(date_start=date(2012,3, 13), date_end=date(2017,3, 13)))

x= []
customers =[]
staffs = []
cars = []
letters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
branch_ids_select = [1,2,3]
branch_ids = []
car_branch = {}
# 1
sexes = ['M', 'F']

with open('Staff.csv', 'w') as csvfile:
    
    postition = ['Manager', 'Assisstant']
    fieldnames = ['staff_id','f_name','l_name','sex','staff_DOB','staff_ppsn','staff_position','staff_address1','staff_address2','staff_city','staff_cont_tel','staff_cont_email', 'staff_salary', 'branch_id']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    for i in range(0,60):
        print("Table 1 rows completed: " + str(i))
        sex = sexes[random.randint(0,1)]
        if (sex == 'M'):
            f_name=fake.first_name_male()
        else:
            f_name=fake.first_name_female()

        if (i%3==0):
            branch_id = 0
        elif(i%3 == 1):
            branch_id = 1
        else:
            branch_id = 2
        staffs.append(i+1)
        f_name=fake.first_name()
        l_name = fake.last_name()
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writerow({'staff_id':i+1,'f_name': f_name,'l_name': l_name, 'sex': sex, 'staff_DOB': fake.date_between_dates(date_start=date(1960,3, 13), date_end=date(1992,3, 13)),'staff_ppsn':str(random.randint(1000000, 9999999)) + letters[random.randint(0, 25)] ,'staff_position': postition[random.randint(0, 1)], 'staff_address1': fake.street_address(),'staff_address2': fake.street_name(),'staff_city': fake.city(),'staff_cont_tel': fake.phone_number(),'staff_cont_email': f_name+l_name+'@gmail.com', 'staff_salary':generateSalary(), 'branch_id': branch_ids_select[branch_id]})

# 2
with open('Customer.csv', 'w') as csvfile:
    print(1)
    fieldnames = ['cust_id','f_name','l_name', 'sex', 'cust_DOB','pass_num','cust_address1','cust_address2','cust_city','zip_code','cust_contact_tel','cust_contact_email', 'licence']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    # writer.writeheader()
    for i in range(0,10000):
        print("Table 2 rows completed: " + str(i))
        customers.append(i+1)
        f_name=fake.first_name()
        l_name = fake.last_name()
        lice = str(random.randint(1000000, 9999999))
        sex = sexes[random.randint(0,1)]
        if (sex == 'M'):
            f_name=fake.first_name_male()
        else:
            f_name=fake.first_name_female()
        l_name = fake.last_name()

        writer.writerow({'cust_id': i+1,'f_name': f_name,'l_name': l_name, 'sex': sex,'cust_DOB': fake.date_between_dates(date_start=date(1960,3, 13), date_end=date(1992,3, 13)),'pass_num':str(random.randint(1000000, 9999999)) + letters[random.randint(0, 25)] ,'cust_address1': fake.street_address(), 'cust_address2': fake.street_name(),'cust_city': fake.city(),'zip_code': fake.zipcode_plus4(),'cust_contact_tel': fake.phone_number(),'cust_contact_email': f_name+l_name+'@gmail.com', 'licence':lice})
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)


regLetters = ['D','C','KY']
fuelType = ['Petrol', 'Diesel']

# 3
with open('Cars.csv', 'w') as csvfile:
    fieldnames = ['car_id','reg_num','year_prod', 'class_id', 'model_id', 'branch_id']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    temp = 0
    for i in range(0,600):
        cars.append(i+1)
        year = 12
        regL = regLetters[random.randint(0,2)]
        other = random.randint(1,100000)
        fuel = fuelType[random.randint(0,1)]
        class_id = random.randint(1,4)
        model_id = random.randint(1,10)
        if (i%3==0):
            branch_id = 0
        elif(i%3 == 1):
            branch_id = 1
        else:
            branch_id = 2
        
        print(staffs)
        print(i-temp)
        writer.writerow({'car_id': (i)+1,'reg_num': str(year) +'-'+regL+'-'+str(other),'year_prod': year,  'class_id': 1, 'model_id':model_id, 'branch_id': branch_ids_select[branch_id]})

payments = []
rentid = []
cust_id = 0
carservedate = []
carserve = []
print(len(cars))
car_id = len(cars)/2
staff_id = 0
t = date(2012,3, 5)
changeDate = 0

    
# 4
with open('Rental.csv', 'w') as csvfile:
    fieldnames = ['rent_id','start_date','end_date','cust_id','car_id','staff_id']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    cust_id = 0
    staff_id = 0
    car_id = 0
    wildcard = random.randint(1,4)
    for i in range(0,100000):
        print("Table 4 rows completed: " + str(i))
        cust_id +=random.randint(1,7)

        cust_wildcard = random.randint(1,15)

        if ((cust_id+cust_wildcard) >= len(customers)):
            cust_id = 0
            
        
        cust_id += cust_wildcard
        print(cust_id)
        
        if ((i+wildcard) >= len(staffs)):
            staff_id = ((i+wildcard)%len(staffs))
            
        else:
            staff_id = (i+wildcard)

        
        if ((i+wildcard) >= len(cars) or i != 0):
            car_id = ((i+wildcard)%len(cars))
            
        else:
            car_id = (i+wildcard)

        branch_id = 0
        if (i%3==0):
            branch_id = 0
        elif(i%3 == 1):
            branch_id = 1
        else:
            branch_id = 2

        changeDate+=1
        z = random.randint(52,53)
        if(changeDate % z == 0):
            t+= timedelta(days=1)
        day = random.randint(7, 30)
        payments.append(t- timedelta(days=random.randint(0,7)))
        rentid.append(i+1)
        modified_date = t + timedelta(days=day)
        x = 0
        if (i >= len(cars)):
            x = (i%len(cars))
        else:
            x = i
        
        print(car_id)
        # branch_id = staffs[x]
        carservedate.append(modified_date+timedelta(days=1))
        carserve.append(i+1)
        writer.writerow({'rent_id': i+1, 'start_date': t, 'end_date': modified_date, 
        'cust_id': customers[cust_id], 'car_id': cars[car_id], 'staff_id': staffs[staff_id]})

# # 5
with open('Payment.csv', 'w') as csvfile:
    fieldnames = ['Payment_Id', 'Payment_Date', 'rent_id']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    for i in range(0,100000):
        print("Table 5 rows completed: " + str(i))
        writer.writerow({'Payment_Id': i+1, 'Payment_Date': payments[i], 'rent_id': rentid[i]})

# # 6
with open('CarService.csv', 'w') as csvfile:
    fieldnames = ['carserv_id', 'serv_type', 'serv_date','serv_cost', 'gar_id', 'car_id']
    serveT = ['Engine Breakdown','Transmission','Gearbox','Wheel Replacement', 'Panel Beating','Light', 'Exhaust', 'Tires', 'Body Paint', 'Breaks', 'Electronics Electric Circuits', 'Battery', 'GPS', 'Security System', 'Lock', 'Body Part Replacement', 'Steering', 'Laser Wheel Alignment', 'Air con', 'Saftey Bag', 'On board computer', 'Sensors', 'Regular maintenance', 'Pre-NCT']
    serveC = [100,50,20,100,50,20,100,50,20,100,50,20,100,50,20,100,50,20,100,50,20,100,50,20]
    print(len(serveT))
    print(len(serveC))
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    for i in range(0,50000):
        print("Table 6 rows completed: " + str(i))
        randServe = random.randint(0,23)
        h = i*2
        car_id = 0
        if (h >= len(cars) or h != 0):
            car_id = (h%len(cars))

        writer.writerow({'carserv_id': i+1, 'serv_type': serveT[randServe], 'serv_date': carservedate[h],'serv_cost': serveC[randServe],'gar_id':random.randint(1,5), 'car_id':car_id+1})

# 7
supplier_Id = [1,2,3,4]
purch_date = date(2012,1, 3)

with open('CarPurch.csv', 'w') as csvfile:
    fieldnames = ['purch_id', 'purch_date', 'purch_price', 'sup_id', 'car_id']
    changeDate = 0
    print(len(serveT))
    print(len(serveC))
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    for i in range(0,600):
        print("Table 7 rows completed: " + str(i))
        
        changeDate+=1
        z = random.randint(10,11)
        if(changeDate % z == 0):
            purch_date+= timedelta(days=1)
        x = 0
        if (i >= len(cars)):
            x = (i%len(cars))
        else:
            x = i
        
        print(car_id)

        carservedate.append(modified_date+timedelta(days=1))
        carserve.append(i+1)
        writer.writerow({'purch_id': i+1, 'purch_date':purch_date, 'purch_price':1, 'sup_id':supplier_Id[random.randint(0,3)], 'car_id':i+1})