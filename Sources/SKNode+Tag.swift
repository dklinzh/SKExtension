//
//  SKNode+Tag.swift
//  SpriteSwift
//
//  Created by Daniel Lin on 2020/7/8.
//  Copyright © 2020 dklinzh. All rights reserved.
//

import SpriteKit

// swiftlint:disable extension_access_modifier
extension SKNode {
    /// The node's tag. Defaults to 0
    public var tag: Int {
        get {
            return self.userData?.object(forKey: "SSTag") as? Int ?? 0
        }
        set {
            if self.userData == nil {
                self.userData = NSMutableDictionary()
            }
            self.userData!.setObject(newValue, forKey: NSString(string: "SSTag"))
        }
    }

    /// Get the first child node of this node that has a certain tag, optionally performing a recusive search, looking at all nodes within this node's tree hierarchy, until a node with the specified tag is found.
    /// - Parameters:
    ///   - tag: The tag to look for
    ///   - recursive: Whether a recrusive search should be performed
    /// - Returns: The first direct child node of this node that has a certain tag
    public func childNode(tag: Int, recursive: Bool = false) -> SKNode? {
        let matches = self.childNodes(tag: tag, recursive: recursive, returnOnFirstMatch: true)
        return matches.first
    }

    /// Get all child nodes of this node that has a certain tag, optionally performing a recusive search, looking at all nodes within this node's tree hierarchy.
    /// - Parameters:
    ///   - tag: The tag to look for
    ///   - recursive: Whether a recrusive search should be performed
    ///   - returnOnFirstMatch: Whether the first direct child nodes that has a certain tag should be return
    /// - Returns: All direct child nodes of this node that has a certain tag
    public func childNodes(tag: Int, recursive: Bool = false, returnOnFirstMatch: Bool = false) -> [SKNode] {
        var nodeMatches = self.children.filter { (node) -> Bool in
            node.tag == tag
        }
        if !recursive || (returnOnFirstMatch && !nodeMatches.isEmpty) {
            return nodeMatches
        }

        for child in self.children {
            let childMatches = child.childNodes(tag: tag, recursive: true, returnOnFirstMatch: returnOnFirstMatch)
            if returnOnFirstMatch, !nodeMatches.isEmpty {
                return childMatches
            }

            nodeMatches.append(contentsOf: childMatches)
        }
        return nodeMatches
    }

    /// Get all child nodes at a point that has a certain tag
    /// - Parameters:
    ///   - point: A point in the node’s coordinate system
    ///   - tag: The tag to look for
    /// - Returns: All child nodes at a point that has a certain tag
    public func nodes(at point: CGPoint, tag: Int) -> [SKNode] {
        let nodes = self.nodes(at: point)
        return nodes.filter { (node) -> Bool in
            node.tag == tag
        }
    }
}
