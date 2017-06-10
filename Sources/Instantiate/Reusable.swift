//
//  Reusable.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/04.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

/// Supports UITableView/UICollectionView reusable features.
/// Implement your UITableViewCell/UICollectionViewCell subclass.
public protocol Reusable: Injectable {
    static var reusableIdentifier: String { get }
}

#if os(iOS)
    
import UIKit

public extension Reusable where Self: UITableViewCell {
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with dependency:Dependency) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
        cell.inject(dependency)
        return cell
    }
}

public extension Reusable where Self: UITableViewCell, Self.Dependency == Void {
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return dequeue(from: tableView, for: indexPath, with: ())
    }
}

public extension Reusable where Self: UITableViewHeaderFooterView {
    public static func dequeue(from tableView: UITableView, with dependency:Dependency) -> Self {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.reusableIdentifier) as! Self
        view.inject(dependency)
        return view
    }
}

public extension Reusable where Self: UITableViewHeaderFooterView, Self.Dependency == Void {
    public static func dequeue(from tableView: UITableView) -> Self {
        return dequeue(from: tableView, with: ())
    }
}

public extension Reusable where Self: UICollectionViewCell {
    public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with dependency:Dependency) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
        cell.inject(dependency)
        return cell
    }
}

public extension Reusable where Self: UICollectionViewCell, Self.Dependency == Void {
    public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return dequeue(from: collectionView, for: indexPath, with: ())
    }
}

public extension Reusable where Self: UICollectionReusableView {
    public static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath, with dependency:Dependency) -> Self {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
        view.inject(dependency)
        return view
    }
}

public extension Reusable where Self: UICollectionReusableView, Self.Dependency == Void {
    public static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath) -> Self {
        return dequeue(from: collectionView, of: kind, for: indexPath, with: ())
    }
}

public extension UITableView {
    public func register<C: UITableViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UITableViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellReuseIdentifier: C.reusableIdentifier)
    }
}

public extension UITableView {
    public func register<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable {
        register(C.self, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
    }
}

public extension UICollectionView {
    public func register<C: UICollectionViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UICollectionViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
}

public extension UICollectionView {
    public func register<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable {
        register(C.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable, C: NibType {
        register(C.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
    }
}

#endif