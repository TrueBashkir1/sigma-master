//-------------------------------------------------------------------------------------------------
//
//         Title:  CDataFile v2.1 (DataFile.h)
//
//     Author(s):  Walter Storm (mailto:nitron@charter.net)
//
//   Description:  This class is designed to handle reading, writing,
//                 and manipulation of large text-based data files.  The
//                 class can handle data as string or as double.  The class
//                 is based on the Standard Template Library and has no 
//                 dependance on MFC yet is fully compatible with it.
//
//         Usage:  You can distribute this software in compiled binary form
//                 so long as this header remains intact and this work is
//                 is not claimed as your own.
//
//   *********************************************************************
//     Version History                                                   
//   *********************************************************************
//     Rev   Date            Details
//   ---------------------------------------------------------------------
//     2.0  05.January.2004  - Initial Release 
//                           - Complete rewrite from CDataFile 1.x
//
//     2.1  24.January.2004  - Fixed issues for building with VC6
//
//
//-------------------------------------------------------------------------------------------------

#pragma once

#if !defined(_DataFile_H__INCLUDED_)
#define _DataFile_H__INCLUDED_

// supress warnings (pop statement at end)
#pragma warning(push)

#pragma warning(disable:4786) // 255 char truncation in VC6
#pragma warning(disable:4702) // unreachable code in std::vector (VC7)

// required STL headers
#include <algorithm>
#include <exception>
#include <fstream>
#include <functional>
#include <string>
#include <vector>


// forward declarations
class CDataFile;

// define constants in the DF namespace
namespace DF
{
	// defines the maximum width of a line in a file
	static const int   MAX_LINE_BUFFER    = 0xFFFFF;

	// defines the makimum length of a field in a file
	static const int   MAX_FIELD_BUFFER   =    1024;

	// set std::vector::reserve() with this value
	static const int   DEFAULT_RESERVE    = 0x0FFFF;	

	// defines the default field delimiter in a file
	static const char* DEFAULT_DELIMITER  =     ",";

	// enumeration of read flags
	static const enum readflags
	{
		RF_READ_AS_DOUBLE = 0x00000001,
		RF_READ_AS_STRING = 0x00000002,
		RF_APPEND_DATA    = 0x00000004,
		RF_REPLACE_DATA   = 0x00000008
	};

	// errorcode table for error reporting
	static const char* ERRORCODES[] = 
	{
		"ERROR 0000: UNKNOWN ERROR",
		"ERROR 0001: An unknown error occurred in GetString()!",
		"ERROR 0002: An unknown error occurred in GetData()!",
		"ERROR 0003: GetString() was called while the dwReadFlags was not READ_AS_STRING.",
		"ERROR 0004: GetData() was called while the dwReadFlags was not RF_READ_AS_DOUBLE.",
		"ERROR 0005: Variable name not found!",
		"ERROR 0006: Filename name not found!",
		"ERROR 0007: File not found!",
		"ERROR 0008: The Number of Headers is different than the Number of Data Columns!"
	};

	// defines the double return value when an error is encountered
	static const double ERRORVALUE = 1234567890987654321.1234567890987654321;

	// DF_SELECTION type.  This is to define a range
	// of values within a CDataFile.
	typedef struct tagDF_SELECTION
	{
		int iVar[2];
		int iSamp[2];
		CDataFile* pDataFile;
	} DF_SELECTION;
}

// the CDataFile class
class CDataFile
{
public:

	// The default constructor.  Instantiates an instance of CDataFile and 
	// initialize data members to default values.
	CDataFile(void);

	// Copy constructor.  Instantiates an instance of CDataFile with the
	// contents of another CDataFile.
	CDataFile(const CDataFile& df);

	// Quasi-Copy constructor.  Instantiates an instance of CDataFile with the
	// contents of another CDataFile as defined by the DF_SELECTION.
	CDataFile(const DF::DF_SELECTION&);

	// Misc. constructor.  Instantiates an instance of CDataFile with the
	// specified read flags.
	CDataFile(const int& dwReadFlags);

	// Misc. constructor.  Instantiates an instance of CDataFile and reads the
	// specified file with the specified read flags.
	CDataFile(const char* szFilename, const int& dwReadFlags = DF::RF_READ_AS_DOUBLE);
	

	// Returns a CDataFile with one variable created with the specified name and data.
	// Assumes readflag DF::RF_READ_AS_DOUBLE.
	static CDataFile FromVector(const char* szVariableName, const std::vector<double>& vData);

	// Returns a CDataFile with one variable created with the specified name and data.
	// Assumes readflag DF::RF_READ_AS_STRING.
	static CDataFile FromVector(const char* szVariableName, const std::vector<std::string>& vData);
		

	// Calls ClearData() before the CDataFile is destroyed.
	~CDataFile(void);


	// Clears the data contained in a CDataFile 
	// and reclaims any allocated memory.
	void ClearData();

	// Deletes the variable whose index is iVariable from a CDataFile.
	// Returns true if successful, false if an error is encountered.
	bool DeleteVariable(const int& iVariable);
	
	// Returns the data at the specified location.  
	// Assumes readflag DF::RF_READ_AS_DOUBLE.
	// Returns DF::ERRORVALUE if an error is encountered.
	double GetData(const int&  iVariable, const int& iSample);

	// Returns the data at the specified location.  
	// Assumes readflag DF::RF_READ_AS_DOUBLE.
	// Returns DF::ERRORVALUE if an error is encountered.
	double GetData(const char* szVariableName, const int& iSample);

	// Assigns rVector with the data at the target variable.
	// Returns the new size of rVector.  
	// Assumes readflag DF::RF_READ_AS_DOUBLE.
	// Returns -1 if an error is encountered.
	int GetData(const int&  iVariable, std::vector<double>& rVector);

	// Assigns rVector with the data at the target variable.
	// Returns the new size of rVector.  
	// Assumes readflag DF::RF_READ_AS_DOUBLE.
	// Returns -1 if an error is encountered.
	int GetData(const char* szVariableName, std::vector<double>& rVector);

	// Assigns lpStr with the data at the target variable.
	// Returns the new length of lpStr.  
	// Assumes readflag DF::RF_READ_AS_STRING.
	// Returns -1 if an error is encountered.
	int GetData(const int&  iVariable, const int& iSample, char* lpStr);

	// Assigns lpStr with the data at the target variable.
	// Returns the new length of lpStr.  
	// Assumes readflag DF::RF_READ_AS_STRING.
	// Returns -1 if an error is encountered.
	int GetData(const char* szVariableName, const int& iSample, char* lpStr);

	// Assigns rStr with the data at the target variable.
	// Returns the new length of rStr.  
	// Assumes readflag DF::RF_READ_AS_STRING.
	// Returns -1 if an error is encountered.
	int GetData(const int&  iVariable, const int& iSample, std::string& rStr);

	// Assigns rStr with the data at the target variable.
	// Returns the new length of rStr.  
	// Assumes readflag DF::RF_READ_AS_STRING.
	// Returns -1 if an error is encountered.
	int GetData(const char* szVariableName, const int& iSample, std::string& rStr);

	// Assigns rVector with the data at the target variable.
	// Returns the new size of rVector.  
	// Assumes readflag DF::RF_READ_AS_STRING.
	// Returns -1 if an error is encountered.
	int GetData(const int&  iVariable, std::vector<std::string>& rVector);

	// Assigns rVector with the data at the target variable.
	// Returns the new size of rVector.  
	// Assumes readflag DF::RF_READ_AS_STRING.
	// Returns -1 if an error is encountered.
	int GetData(const char* szVariableName, std::vector<std::string>& rVector);

	// Looks up the index of a variable given its name, starting at the
	// specified index.  Returns the index if successful, -1 if an error 
	// is encountered.
	int GetVariableIndex(const char* szVariableName, const int& iStartingIndex = 0);

	// Looks up the index of a variable given its name and origional source
	// file, starting at the specified index.  Returns the index if successful, 
	// -1 if an error is encountered.
	int GetVariableIndex(const char* szVariableName, const char* szSourceFilename, const int& iStartingIndex = 0);

	// Assigns the variable name at the specified index to lpStr.
	// Returns the new length of lpStr if successful, -1 if
	// an error is encountered.
	int GetVariableName(const int& iVariable, char* lpStr);

	// Assigns the variable name at the specified index to rStr.
	// Returns the new length of rStr if successful, -1 if
	// an error is encountered.
	int GetVariableName(const int& iVariable, std::string& rStr);
	
	// Reads the specified file with the specified read flags.
	// Returns true if successful, false if an error is encountered.
	bool ReadFile(const char* szFilename, const unsigned& dwReadFlags);

	// Reads the specified file with the current read flags.
	// Returns true if successful, false if an error is encountered.
	bool ReadFile(const char* szFilename) { return ReadFile(szFilename, m_dwReadFlags); }
	
	// Attempts to set the specified element to value.  Returns true
	// if successful, false if an error is encountered.
	bool SetData(const int&  iVariable, const int& iSample, const double& value);

	// Attempts to set the specified element to szValue.  Returns true
	// if successful, false if an error is encountered.
	bool SetData(const int&  iVariable, const int& iSample, const char* szValue);

	// Attempts to append a data point to the variable specified
	// by iVariable.  Returns true if successful, false if an error is encountered.
	bool AppendData(const int& iVariable, const double& value);

	// Attempts to append a data point to the variable specified
	// by iVariable.  Returns true if successful, false if an error is encountered.
	bool AppendData(const int& iVariable, const char* szValue);

	// Attempts to append values from vData to the variable specified
	// by iVariable.  Returns true if successful, false if an error is encountered.
	bool AppendData(const int& iVariable, const std::vector<double>& vData);

	// Attempts to append values from vszData to the variable specified
	// by iVariable.  Returns true if successful, false if an error is encountered.
	bool AppendData(const int& iVariable, const std::vector<std::string>& vszData);

	// Attempts to create a variable with the name specified by szName with a size of 
	// iSize and an initial_value. Returns true if successful, false if an error is encountered.
	bool CreateVariable(const char* szName, const double& initial_value, const int& iSize = 0);

	// Attempts to create a variable with the name specified by szName with a size of 
	// iSize and an initial_value. Returns true if successful, false if an error is encountered.
	bool CreateVariable(const char* szName, const std::string& initial_value, const int& iSize = 0);

	// Attempts to create a variable with the name specified by szName and the values
	// contained in vData. Returns true if successful, false if an error is encountered.
	bool CreateVariable(const char* szName, const std::vector<double>& vData);

	// Attempts to create a variable with the name specified by szName and the values
	// contained in vszData. Returns true if successful, false if an error is encountered.
	bool CreateVariable(const char* szName, const std::vector<std::string>& vszData);
 
	// Override of operator >> for stream extraction.
	friend std::istream& operator >> (std::istream&, CDataFile&);

	// Override of operator << for stream insertion.
	friend std::ostream& operator << (std::ostream&, const CDataFile&);

	// Override of operator << for stream insertion of a DF_SELECTION
	friend std::ostream& operator << (std::ostream&, const DF::DF_SELECTION&);

	// Assigns a CDataFile equal to another CDataFile.
	CDataFile& operator =(const CDataFile&);

	// Assigns a DF_SELECTION to a CDataFile.
	CDataFile& operator =(const DF::DF_SELECTION&);
	
	// Appends a CDataFile to another CDataFile.
	CDataFile& operator+=(const CDataFile&);	

	// Combines CDataFile(s)
	CDataFile  operator+ (const CDataFile&) const;

	// Returns a selection (DF_SELECTION) based on the coordinates passed.
	// (Think of it as highlighting cells in Excel.)
	DF::DF_SELECTION operator()(const int& left, const int& top, const int& right, const int& bottom); 

	// Returns a copy of the value specified by the given coordinates.
	double operator()(const int& iVariable, const int& iSample);

	// Assigns lpStr the value at the specified location.  Returns the new length
	// of lpStr if successful, -1 if an error is encountered.
	int operator()(const int& iVariable, const int& iSample, char* lpStr);

	// The magical [][] operator...
	// Returns a REFERENCE to the value at the specified location.
	// i.e.: to set Variable 4, Sample 6 equal to 2.121, use the following:
	// df[4][6] = 2.121;
	// Note: This is only defined for DF::RF_READ_AS_DOUBLE, not for strings.
	std::vector<double>& operator[](const int& in) { return m_v2dData.at(in); }
    
	// Attempts to write the CDataFile to the location specified by szFilename
	// using the delimiter specified by szDelim.  Returns true if successful, 
	// false if an error is encountered.
	bool WriteFile(const char* szFilename, const char* szDelim = ",");

	// Returns the last error encountered by the class.
	const char* GetLastError() const { return m_szError.c_str(); }

	// Returns the number of variables currently in the CDataFile.
	int GetNumberOfVariables() const { return static_cast<int>(m_vstrVariableNames.size()); }
	
	// Returns the number of samples currently in the variable.
	int GetNumberOfSamples(const int& iVariable)  const
	{ 
		return (m_dwReadFlags & DF::RF_READ_AS_DOUBLE           ? 
			static_cast<int>(m_v2dData.at(iVariable).size())    :
			static_cast<int>(m_v2dStrData.at(iVariable).size())); 
	}

	// Get Read Flags
	int  GetReadFlags(void) const { return m_dwReadFlags; }

	// Set Read Flags
	void SetReadFlags(const unsigned& dwReadFlags) { m_dwReadFlags = dwReadFlags; }

	// Sets the delimiter to use for parsing data.
	void SetDelimiter(const char* delim) { m_delim = delim; }
	
	// Sets the reserve value for data storage.
	void SetReserve(const int& nReserve) { m_reserve = nReserve; }

private:

	// Private member function for internal bookeeping.
	int LookupVariableIndex_(const char* szName, const int& offset=0) const;
	// Private member function for internal bookeeping.
	int GetLargestVectorSize_() const;
	std::string m_delim;
	int m_dwReadFlags;
	int m_reserve;
	std::string m_szFilename;
	std::string m_szError;
	std::vector<std::string> m_vstrVariableNames;
	std::vector<std::string> m_vstrSourceFilenames;
	std::vector<std::vector<std::string> > m_v2dStrData;
	std::vector<std::vector<double> > m_v2dData;
};

// restore warnings
#pragma warning(pop) 

#endif // !defined(_CDataFile_H__INCLUDED_)