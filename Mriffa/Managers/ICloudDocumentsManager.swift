//
//  ICloudDocumentsManager.swift
//  Mriffa
//
//  Created by Sergei Volkov on 18.09.2021.
//

import Foundation

struct ICloudDocumentsManager {
    private init() {}
    
    enum ICloudFolder: String {
        case mainHiddenFolder = "Backup"
        case iCloudDocumentsFolder = "Documents"
    }
    
    enum ICloudError: Error {
        case iCloudAccessDenied
        case noFilesInContainer
    }
    
    static func saveFilesToICloudDOcuments(localFilePaths: [String], icloudFolder: ICloudFolder) throws {
        localFilePaths.forEach { filePath in
            if let fileName = filePath.components(separatedBy: "/").last {
                try? copyFileToICloud(localPath: filePath,
                                      icloudFolder: icloudFolder,
                                      fileName: fileName)
            }
        }
    }
    
    private static func containerUrl(folder: ICloudFolder) -> URL? {
        return FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent(folder.rawValue)
    }
    private static func urlFileToCopy(folder: ICloudFolder, fileName: String) -> URL? {
        return containerUrl(folder: folder)?.appendingPathComponent(fileName)
    }
    private static func createDirectoryInICloud(folder: ICloudFolder) throws {
        if let url = containerUrl(folder: folder) {
            if !FileManager.default.fileExists(atPath: url.path, isDirectory: nil) {
                do {
                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                } catch let directoryError {
                    print(directoryError)
                    throw directoryError
                }
            }
        } else {
            throw ICloudError.iCloudAccessDenied
        }
    }
    private static func copyFileToICloud(localPath: String, icloudFolder: ICloudFolder, fileName: String) throws {
        do {
            try createDirectoryInICloud(folder: icloudFolder)
        } catch let copyError {
            print(copyError)
            throw copyError
        }
        guard let urlFileName = urlFileToCopy(folder: icloudFolder, fileName: fileName) else {
            throw ICloudError.iCloudAccessDenied
        }
        
        if FileManager.default.fileExists(atPath: localPath) {
            do {
                try removeOldFile(path: urlFileName.path)
            } catch let removeError {
                print(removeError)
                throw removeError
            }
        }
        do {
            try FileManager.default.copyItem(atPath: localPath, toPath: urlFileName.path)
            print("file \(fileName) copyFileToICloud is ok")
        } catch {
            print("error copy file '\(fileName)' to icloud - " + error.localizedDescription)
            throw error
        }

    }
    
    static func downloadFilesFromIcloud(localFolder: URL, folder: ICloudFolder, containerName: String?, completion: @escaping (Error?)->Void) {
        if let container = containerUrl(folder: folder) {
            do {
                try FileManager.default.startDownloadingUbiquitousItem(at: container)
            } catch {
                completion(error)
                
            }
            if let fileList = try? FileManager().contentsOfDirectory(at: localFolder, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) {
                fileList.forEach { fileUrl in
                    try? removeOldFile(path: fileUrl.path)
                }
            }
            
            if let containerFiles = try? FileManager().contentsOfDirectory(at: container, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) {
                if containerFiles.isEmpty {
                    completion(ICloudError.noFilesInContainer)
                } else {
                    
                    containerFiles.forEach { containerFileUrl in
                        if let fileName = containerFileUrl.path.components(separatedBy: "/").last {
                            
                            if FileManager.default.fileExists(atPath: DataManager.localFolderURL.appendingPathComponent(fileName).path) {
                                do {
                                    try removeOldFile(path: DataManager.localFolderURL.appendingPathComponent(fileName).path)
                                } catch let removeError {
                                    print(removeError)
                                    completion(removeError)
                                }
                            }
                            
                            do {
                                try FileManager.default.copyItem(atPath: containerFileUrl.path,
                                                                 toPath: localFolder.appendingPathComponent(fileName).path)
                            } catch {
                                completion(error)
                            }
                            print("copy file: \(fileName)")

                        }
                        
                    }
                    completion(nil)
                }
            }
            
            
        } else {
            completion(ICloudError.iCloudAccessDenied)
        }
    }
    
    private static func removeOldFile (path: String) throws {
        var isDir:ObjCBool = false
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
               throw error
            }
        }
    }
}

extension ICloudDocumentsManager.ICloudError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .iCloudAccessDenied:
            return NSLocalizedString("Access denied to iCloud. Please sign into your icloud account in to iphone. Check internet connection.", comment: "error description")
        case .noFilesInContainer:
            return NSLocalizedString("No files in iCloud", comment: "error description")
        }
    }
}
