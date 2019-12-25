CREATE DATABASE toolbox;
USE toolbox;

/*					INICIO
*******	CREACION DE USUARIOS Y ROLES DE USUARIO **********
*/


CREATE TABLE userGeneral(
	userId int primary key not null auto_increment,
    userEmail varchar(50) not null,
    userPassword varchar(50) not null,
    userName varchar(50) not null,
    userTelephone varchar(50),
    userAddress varchar(50) not null,
    userLastName varchar(50) not null,
    userPicture varchar(50),
    userBirthDate date not null,
    userEmailConfirmed boolean 
);

CREATE TABLE userRole (
	userRoleId int not null primary key,
    userRoleName varchar(50) not null
);

CREATE TABLE userRoleAssigned(
	userRoleAID int primary key not null auto_increment,
    userId int not null,
    userRoleId int not null,
    userRoleAssignedAt  datetime not null default current_timestamp,
	foreign key(userId) references userGeneral(userId),
    foreign key(userRoleID) references userRole(userRoleId)
);

/*						     FIN
		****** CREACION DE USUARIOS Y ROLES DE USUARIO *********
*/
/*					INICIO
		**** CREACION DE METODOS DE  PAGO *****
*/
CREATE TABLE cashPaymentMethod (
	cashPaymentID int primary key not null auto_increment,
    cashPaymentInUse boolean
);

CREATE TABLE mercadoPagoMethod(
	mercadoPagoID int primary key not null auto_increment,
    mercadoPagoEmail varchar(45) not null,
    mercadoPagoPassword varchar(45) not null
);

CREATE TABLE payPalMethod (
	paypalID int primary key not null auto_increment,
    paypalEmail varchar(50) not null,
    payPalPassword varchar(50) not null
);

CREATE TABLE cardMethod (
	cardID int primary key not null auto_increment,
    cardNumber long not null,
    cardCVVNumber int,
    cardName varchar(50),
    cardClientName varchar(50),
    cardValidDate date
);

CREATE TABLE userPaymentMethods (
	paymentMethodID int primary key not null auto_increment,
    userId int not null,
    paymentMethodId_foreign int not null,
    paymentMethodName varchar(50) not null,
    userPaymentDate datetime not null default current_timestamp,
    foreign key(userId) references userGeneral(userId)
);

/*					FIN
		**** CREACION DE METODOS DE  PAGO *****
*/
/*					INICIO
		**** CREACION DE PRODUCTOS *****
*/

CREATE TABLE product (
	productID int not null auto_increment primary key,
    productDescription varchar(50) not null,
    productBrand varchar(50),
    productPrice decimal not null,
    productModel varchar(50),
    productName varchar(50) not null,
    productQuantity int,
    productDate datetime not null default current_timestamp
);

CREATE TABLE productImages (
	idImages int not null auto_increment primary key,
    imageRoute varchar(100) not null,
    productID int not null,
	foreign key(productID) references product(productID)
);

CREATE TABLE productRate (
	productRateId int not null auto_increment primary key,
    productRate int not null,
    userId int not null,
    productID int not null,
    foreign key (productID) references product(productID),
    foreign key (userId) references userGeneral(userId)
);

CREATE TABLE productComments(
	productCommentID int not null auto_increment primary key,
    productComment varchar(50) not null,
    productID int not null,
    userId int not null,
    productCommentDate datetime not null default current_timestamp,
    foreign key (productID) references product(productID),
    foreign key (userId) references userGeneral(userId)
);

CREATE TABLE userPartnerProducts (
	userPartnerProductsID int not null auto_increment primary key,
    userId int not null,
    productID int not null,
    foreign key (productID) references product(productID),
    foreign key (userId) references userGeneral(userId)
);
/*					FIN
		**** CREACION DE PRODUCTOS *****
*/
/*					INICIO
		**** CREACION DE PAGOS *****
*/
CREATE TABLE payment(
	paymentID int not null primary key auto_increment,
    paymentPrice decimal not null,
    paymentProductQuantity int not null,
    paymentPickup varchar(50) not null,
    paymentStatus varchar(50) not null,
    paymentDate datetime not null default current_timestamp
);

CREATE TABLE productPayment (
	productPaymentId int not null primary key auto_increment,
    productID int not null,
    paymentID int not null,
	foreign key (productID) references product(productID),
    foreign key (paymentID) references payment(paymentID)
);

CREATE TABLE usersPayment (
 idUserPayment int not null primary key auto_increment,
 idPaymentClientUser int not null,
 idPaymentUserPartner int not null,
 paymentID int not null,
 foreign key (paymentID) references payment(paymentID),
 foreign key (idPaymentClientUser) references userGeneral(userId),
 foreign key (idPaymentUserPartner) references userGeneral(userId)
);

CREATE TABLE rentPayment (
	rentPaymentID int not null primary key auto_increment,
    rentPaymentTimeStart datetime not null,
    rentPaymentTimeEnd datetime not null,
    paymentID int not null,
    rentPaymentDate datetime not null default current_timestamp,
    foreign key (paymentID) references payment(paymentID)
    );
/*					FIN
		**** CREACION DE Pagos *****
*/