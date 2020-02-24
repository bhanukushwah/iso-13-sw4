pragma solidity >=0.5.16;
pragma experimental ABIEncoderV2;


contract ehr{

    //declaring state variables
    address admin;
    enum gender {male, female, other}

    // crearting constructor
    constructor() public{
        admin = msg.sender;
    }
    // creating the structure patient
    struct patient{
        address owner;
        string name;
        string DOB;
        string addrs;
        string email;
        gender myGender;
        // bool status;
    }
    event PatientCreated(
        address owner,
        string name,
        string DOB,
        string addrs,
        string email,
        gender myGender
        // bool status
    );
    //creating a mapping named person
    mapping(uint => patient) public person;
    //function for entering the mobileno of the person and the structure details of that person
    function setPatient(uint _mobileno, string memory _name, 
    string memory _DOB, string memory _addrs, string memory _email, 
    gender _myGender) public {
    
    // for(uint i = 0; i < patient.length; i++) {

    // }
    person[_mobileno] = patient(msg.sender,_name, _DOB, _addrs, _email, _myGender);
    
    emit PatientCreated(msg.sender,_name, _DOB, _addrs, _email, _myGender);

    }
    // function for viewing the patient using the mobile number
    function getPatient(uint _mobileno) public view returns (string memory _name, 
    string memory _DOB, string memory _addrs, 
    string memory _email, 
    gender _myGender, 
    string memory _emergencycontact, uint _emergno){
        _name = person[_mobileno].name;
        _DOB = person[_mobileno].DOB;
        _addrs = person[_mobileno].addrs;
        _email = person[_mobileno].email;
        _myGender = person[_mobileno].myGender;
    }

    // function loginPatient(address key) public returns (bool valid) {

    // }

    // creating the structure doctor
    struct doctor{
        address publickey;
        string name;
        string DOB;
        string addrs;
        string email;
        gender myGender;
        string hospitalname;
        string qualifications;
    }
    event DoctorCreated(
        address publickey,
        string name,
        string DOB,
        string addrs,
        string email,
        gender myGender,
        string hospitalname,
        string qualifications
    );
    //creating a mapping named dctr for the doctor
    mapping(uint => doctor) public dctr;

//function for entering the id of the dctr and the structure details of that doctor
    function setDoctor(uint _id,address _publickey, string memory _name, string memory _DOB, string memory _addrs, string memory _email, gender _myGender, string memory _hospitalname, string memory _qualifications) public {
        dctr[_id] = doctor(_publickey, _name, _DOB, _addrs, _email, _myGender, _hospitalname, _qualifications);

        emit DoctorCreated(_publickey, _name, _DOB, _addrs, _email, _myGender, _hospitalname, _qualifications);
    }

// function for viewing the doctor using the id
    function getDoctor(uint _id) public view returns (address _publickey, 
    string memory _name, 
    string memory _DOB, 
    string memory _addrs, 
    string memory _email, 
    gender _myGender, 
    string memory _hospitalname, 
    string memory _qualifications){

        _publickey = dctr[_id].publickey;
        _name = dctr[_id].name;
        _DOB = dctr[_id].DOB;
        _addrs = dctr[_id].addrs;
        _email = dctr[_id].email;
        _myGender = dctr[_id].myGender;
        _hospitalname = dctr[_id].hospitalname;
        _qualifications = dctr[_id].qualifications;
    }

    //cerating structure for hospital
    struct hospital{
        address publickey;
        string name;
        string email;
        uint phone;
        string ownership;
        string haddress;
    }

    event HospitalCreated(
        address publickey,
        string name,
        string email,
        uint phone,
        string ownership,
        string haddress
    );

    //creating mapping for hospital
    mapping(uint => hospital) public hospitaldetails;

    //creating modifier for owner only condition
    modifier only_owner(){
        require(msg.sender == admin);
        _;
    }

    //function to set the hospital with the with the mapping hospital id
    function setHospital(uint _id, address _publickey, string memory _name, string memory _email, uint  _phone, string memory _ownership,string memory _haddress) public only_owner returns (bool){
        hospitaldetails[_id] = hospital(_publickey, _name, _email, _phone, _ownership, _state, _place, _haddress);
    
    emit HospitalCreated(_publickey, _name, _email, _phone, _ownership, _state, _place, _haddress);
    } 
    //function to get the hospital details with the hospital id
    function getHospital(uint _id) public view returns (address _publickey, string memory _name, string memory _email, uint  _phone, string memory _ownership, string memory _haddress){

        _publickey = hospitaldetails[_id].publickey;
        _name = hospitaldetails[_id].name;
        _email = hospitaldetails[_id].email;
        _phone = hospitaldetails[_id].phone;
        _ownership = hospitaldetails[_id].ownership;
        _haddress = hospitaldetails[_id].haddress;
    }

    //creating structure to insert the medical certificates
    struct medicalcertificates{
        string record;
    }

    //uploading medical certificates and viewing the certificates

    mapping(uint => mapping(uint => string)) public addcerti;
    mapping(uint => uint) public certcount;
 

 function setCertificate (uint _mobileno, string memory _certhash) public {
     uint ccount = certcount[_mobileno] + 1;
     addcerti[_mobileno][ccount] = _certhash;
     setcount(_mobileno, ccount);
     
 }
 function setcount(uint _mobileno, uint _count) public{
     certcount[_mobileno] = _count;
 }

    

}