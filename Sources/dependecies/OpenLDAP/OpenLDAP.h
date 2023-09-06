//
//  OpenLDAP.h
//  OpenLDAP
//
//  Created by BACEM FATNASSI on 5/9/2023.
//

@import Foundation;

//! Project version number for OpenLDAP.
FOUNDATION_EXPORT double OpenLDAPVersionNumber;

//! Project version string for OpenLDAP.
FOUNDATION_EXPORT const unsigned char OpenLDAPVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <OpenLDAP/PublicHeader.h>

#include "ldap.h"
#include "lber.h"
#include "lber_types.h"
