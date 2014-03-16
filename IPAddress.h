//
//  IPAddress.h
//  FileManagerDEMO
//
//  Created by Xchobo on 12/8/12.
//  Copyright (c) 2012年 Xchobo. All rights reserved.
//

//#ifndef FileManagerDEMO_IPAddress_h
//#define FileManagerDEMO_IPAddress_h

#define MAXADDRS	32

extern char *if_names[MAXADDRS];
extern char *ip_names[MAXADDRS];
extern char *hw_addrs[MAXADDRS];
extern unsigned long ip_addrs[MAXADDRS];

// Function prototypes

void InitAddresses();
void FreeAddresses();
void GetIPAddresses();
void GetHWAddresses();

//#endif
