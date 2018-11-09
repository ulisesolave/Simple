//
//  AppDelegate.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 6/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var restrictRotation:UIInterfaceOrientationMask = .portrait

    var logueadoFirebase = false
    var existeCuentaRealm = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
    
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        print("APP DELEGATE")
        
        
        print("URL REALM")
        print(Realm.Configuration.defaultConfiguration.fileURL)



//        try? FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
////
//
//        do {
//            try FileManager.default.removeItem(at:Realm.Configuration.defaultConfiguration.fileURL!)
//
//        } catch {
//            print("ERROR BORRAR BD REALM")
//            print("error")
//        }
        
        
        
        
        
        do {
            let realm = try Realm()
            
        } catch {
            print("ERROR REALM")
            print(error)
        }
        

        var userID = ""
        
        // esta logueado?
        if Auth.auth().currentUser != nil {
            logueadoFirebase = true
            //poner sesion a usuario
            userID = Auth.auth().currentUser!.uid
            let s = Sesion()
            
            s.userID = userID
            let realm = try! Realm()
            let ses = realm.objects(Sesion.self).first
            
            if ses == nil {
                do {
                    try realm.write {
                        realm.add(s)
                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
            } else {
                do {
                    try realm.write {
                        ses?.userID = userID
                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
            }
            
        } else {
            logueadoFirebase = false
        }
        
       
        let realm = try! Realm()

        let usuario =  realm.objects(Persona.self).filter("userID == %@", userID).first

        
//        print("EXISTE CUENTA")
//        print(usuario)
        
        if usuario == nil {
            existeCuentaRealm = false
            print("ES NIL")
            }else {
            existeCuentaRealm = true
            print("no es nil")
        }
        
        if logueadoFirebase == true {
            print("A")
            if existeCuentaRealm == true {
                print("B")
                let viewController = self.window!.rootViewController!.storyboard!.instantiateViewController(withIdentifier: "TabBarViewController")
                self.window?.rootViewController = viewController
                
//                if window?.rootViewController as? UITabBarController != nil {
//                    let tabBarController = window!.rootViewController as! UITabBarController
//                    tabBarController.selectedIndex = 0
//                }
            } else {
                //cerrar sesion FIREBASE
                do {
                    try Auth.auth().signOut()
                } catch {
                    print("ERROR EN SALIR LOGOUT DE FIREBASE")
                }
                
                //Aca es cuando inicio sesion en otro dispositivo
                
                print("C")
                let viewController = self.window!.rootViewController!.storyboard!.instantiateViewController(withIdentifier: "VideoVC")
                self.window?.rootViewController = viewController
            }
            
            
        } else {
            print("D")
            let viewController = self.window!.rootViewController!.storyboard!.instantiateViewController(withIdentifier: "VideoVC")
            self.window?.rootViewController = viewController
            
            
        }
        
        
        return true
        print("TERMINA APP DELEGATE")
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.restrictRotation

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("APP ENTRO A BACKGROUND")

        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("APP ENTRO A FOREGROUND")

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("APP BECOME ACTIVE")

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        print("APP TERMINA")

        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "InicioSesionFB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    private func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application( application, open: url, options: options)
        return handled
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("MEMORIA SE FUE A LA CONCHA")
    }
    
    

}

