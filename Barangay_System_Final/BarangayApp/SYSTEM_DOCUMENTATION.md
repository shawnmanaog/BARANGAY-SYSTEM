# Barangay Management System - Documentation

## Overview
The Barangay Management System is a comprehensive Flutter application designed to manage all administrative tasks of a barangay (village/town in the Philippines). It provides features for resident management, document request processing, complaint filing, and official management.

## Features

### 1. Dashboard
- Overview of system statistics
- Quick access to key metrics:
  - Total residents count
  - Verified residents count
  - Pending documents count
  - Total complaints count
- Display of active officials
- Quick statistics panel

### 2. Residents Management
- **Add Residents**: Register new residents with comprehensive information
  - First name, last name, email, phone
  - Address and barangay assignment
  - Date of birth
  - Gender and civil status
- **Search & Filter**: Easily find residents by name
- **Verification**: Verify resident accounts
- **View Details**: Access complete resident information
- **Delete**: Remove resident records

### 3. Document Management
- **Document Types**:
  - Barangay Clearance
  - Certificate of Residency
  - Certificate of Indigency
  - Business Clearance
  - First Time Job Seeker Certificate
  - Solo Parent ID
  - KCPE Certificate
  - PWD ID

- **Document Status Workflow**:
  - Pending → Approved → Released
  - Alternative: Rejected

- **Features**:
  - Request documents on behalf of residents
  - Track document requests by status
  - Approve/reject documents
  - Release approved documents
  - Add notes and remarks

### 4. Complaint Management
- **File Complaints**: Register new complaints
  - Complainant information
  - Respondent name
  - Description and location
  - Category classification
  
- **Categories**:
  - Disturbance
  - Theft
  - Assault
  - Property Damage
  - Other

- **Status Tracking**:
  - Filed → Investigating → Resolved → Closed
  
- **Features**:
  - Investigation management
  - Resolution notes
  - Track complaint history
  - Filter by status

### 5. Officials Management
- **Positions**:
  - Barangay Chairman
  - Vice Chairman
  - Kagawad (Councilor)
  - Barangay Secretary
  - Barangay Treasurer
  - Health Worker
  - Barangay Tanod (Barangay Councilor)

- **Features**:
  - Add new officials with term dates
  - View official details
  - Manage term schedules
  - Deactivate officials
  - Contact information management

## Application Structure

### Models (`lib/models/`)
- **resident.dart**: Resident data model
- **document.dart**: Document types and status enums
- **complaint.dart**: Complaint data model
- **official.dart**: Official positions and data model

### Services (`lib/services/`)
- **resident_service.dart**: Resident data management
- **document_service.dart**: Document request processing
- **complaint_service.dart**: Complaint handling
- **official_service.dart**: Official information management

### Screens (`lib/screens/`)
- **home_screen.dart**: Main navigation screen
- **dashboard_screen.dart**: System overview
- **residents_screen.dart**: Resident management
- **documents_screen.dart**: Document processing
- **complaints_screen.dart**: Complaint management
- **officials_screen.dart**: Official management

### Widgets (`lib/widgets/`)
- **stat_card.dart**: Dashboard statistics card
- **add_resident_dialog.dart**: Resident registration form
- **request_document_dialog.dart**: Document request form
- **file_complaint_dialog.dart**: Complaint filing form
- **add_official_dialog.dart**: Official registration form

## Data Flow

1. **User Interface** (Screens)
   ↓
2. **Services** (Business Logic)
   ↓
3. **Models** (Data Objects)
   ↓
4. **In-Memory Storage** (Lists in services)

## How to Use

### Adding a Resident
1. Navigate to the Residents tab
2. Click the Add button (FAB)
3. Fill in all required information
4. Click Save
5. Resident will appear in the list

### Requesting a Document
1. Navigate to Documents tab
2. Click the Add button (FAB)
3. Select resident and document type
4. Enter purpose
5. Click Request
6. Document appears as "Pending"

### Approving Documents
1. Go to Documents tab
2. Click on a pending document
3. Click "Approve" button
4. Document status changes to "Approved"
5. Later, click "Release" to complete

### Filing a Complaint
1. Go to Complaints tab
2. Click the Add button (FAB)
3. Select complainant
4. Enter respondent name and details
5. Choose category and location
6. Click File
7. Track status changes through investigation to resolution

### Managing Officials
1. Go to Officials tab
2. Click Add to register new official
3. Fill in details including position and term dates
4. View or deactivate officials as needed

## Technical Details

### Dependencies
- Flutter SDK 3.0+
- uuid: For generating unique IDs

### State Management
- StatefulWidget-based local state
- Service singleton pattern for data persistence

### Data Persistence
- Currently uses in-memory storage
- Can be extended with SQLite or Firebase

### Platform Support
- iOS 11+
- Android 5.0+

## Future Enhancements

1. **Database Integration**
   - Local SQLite database
   - Firebase backend

2. **Authentication**
   - User login system
   - Role-based access control

3. **Reporting**
   - PDF generation for documents
   - Statistical reports

4. **Notifications**
   - Push notifications for updates
   - Email notifications

5. **Offline Support**
   - Offline data access
   - Sync when online

6. **Advanced Features**
   - Biometric verification
   - Digital signatures
   - Mobile payment integration

## Troubleshooting

### Residents not appearing
- Ensure residents are added before searching
- Refresh the screen

### Documents not saving
- Check all required fields are filled
- Verify resident selection

### Search not working
- Clear search box and try again
- Ensure exact spelling for best results

## Support
For issues or feature requests, please contact the development team.

---
**Version**: 1.0.0  
**Last Updated**: April 2026
