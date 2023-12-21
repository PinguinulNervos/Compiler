#include <iostream>
#include <vector>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

using namespace std;
struct IdInfo {
    string type;
    string name;
    vector<int> array;

};



class IdList {
    vector<IdInfo> vars;
    vector<string> structs;
    vector<string> classes;
    vector<string> list_of_variables_in_struct;
    vector<string> list_of_variables_in_class;
   
    public:
    bool existsVar(const char* s);
    bool existsStructs(const char* s);
    bool existsClass(const char* s);
    void addVar(const char* type, const char* name );
    void addStruct(const char* name );
    void addClass(const char* name );
    void addArray(const char* type, const char* name, int size);
    void printVars();
    bool existsArray(const char* s);
    ~IdList();
};

