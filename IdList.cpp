#include "IdList.h"
using namespace std;

void IdList::addVar(const char* type, const char*name) {
    IdInfo var = {string(type), string(name)};
    vars.push_back(var);
}

void IdList::addStruct(const char*name) {
    structs.push_back(name);
    for(auto x:structs){
    }
}

void IdList::addClass(const char*name) {
    classes.push_back(name);
}


bool IdList::existsVar(const char* var) {
    string strvar = string(var);
     for (const IdInfo& v : vars) {
        if (strvar == v.name) { 
            return true;
        }
    }
    return false;
}

bool IdList::existsStructs(const char* var){
     string str;
     for (auto str : structs) {
        if (var == str){ 
            return true;
        }
    } 
    
    return false;

}

bool IdList::existsClass(const char* var){
     string str;
     for (auto str : classes) {
        if (var == str){ 
            return true;
        }
    }
    return false;
}

bool IdList::existsArray(const char* var) {
    string strvar = string(var);
    for (const IdInfo& v : vars) {
        if (strvar == v.name && !v.array.empty()) { 
            return true;
        }
    }
    return false;
}

void IdList::printVars() {
    for (const IdInfo& v : vars) {
        cout << "name: " << v.name << " type:" << v.type << endl; 
     }
}

void IdList::addArray(const char* type, const char* name, int size) {
        IdInfo var = {string(type), string(name), vector<int>(size, 0)};
        vars.push_back(var);
}



IdList::~IdList() {
    vars.clear();
    structs.clear();
    classes.clear();
}


