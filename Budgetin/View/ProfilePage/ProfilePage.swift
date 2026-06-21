//
//  ProfilePage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        ZStack{
            BackgroundColor()
            
            VStack(spacing: 40) {
                Text("Profile")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color("PrimaryBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 16) {
                    Text("MN")
                        .font(Font.title2)
                        .foregroundStyle(Color("PrimaryWhite"))
                        .frame(width: 60, height: 60)
                        .background(Color("PrimaryGray"))
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("M. Muthi' Nuritzan")
                            .font(Font.headline)
                            .foregroundStyle(Color("PrimaryBlack"))
                        
                        Text("muhammaditzan3@gmail.com")
                            .font(Font.subheadline)
                            .fontWeight(.light)
                            .tint(Color("PrimaryBlack"))
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassEffect(in: .rect(cornerRadius: 24))
//                .shadow(radius: 1)
                
                VStack(spacing: 8) {
                    Text("Preferences")
                        .font(.headline)
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 8) {
                        NavigationLink{
                            EditBudgetPage()
                        } label: {
                            HStack {
                                Text("Monthly Budget")
                                    .foregroundStyle(Color("PrimaryBlack"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color("PrimaryGray"))
                            }
                        }
                        
                        
                        Divider()
                        
                        NavigationLink{
                            ContentAvailableSoon()
                        } label: {
                            HStack {
                                Text("Categories")
                                    .foregroundStyle(Color("PrimaryBlack"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color("PrimaryGray"))
                            }
                        }
                        
                        Divider()
                        
                        NavigationLink{
                            ContentAvailableSoon()
                        } label: {
                            HStack {
                                Text("Notifications")
                                    .foregroundStyle(Color("PrimaryBlack"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color("PrimaryGray"))
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .glassEffect(in: .rect(cornerRadius: 24))
//                    .shadow(radius: 1)
                }
                
                
                
                VStack(spacing: 8) {
                    Text("Account")
                        .font(.headline)
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 8) {
                        NavigationLink{
                            ContentAvailableSoon()
                        } label: {
                            HStack {
                                Text("Edit Profile")
                                    .foregroundStyle(Color("PrimaryBlack"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color("PrimaryGray"))
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .clipShape(.capsule)
                    .glassEffect()
//                    .shadow(radius: 1)
                }
                Spacer()
            }
            .frame(width: 360)
            .padding(.top)
        }
    }
}

#Preview {
    ProfilePage()
}
