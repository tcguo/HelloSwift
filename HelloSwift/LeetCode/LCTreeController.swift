//
//  LCTreeController.swift
//  HelloSwift
//
//  Created by gtc on 2021/7/22.
//

import UIKit
import AudioToolbox

class TreeNode {
    public var left: TreeNode?
    public var right: TreeNode?
    public var val: Int = 0
    
    public init() {
        val = -1
        left = nil
        right = nil
    }
    
    public init(val: Int) {
        self.val = val
    }
    
    public init(val: Int, left:TreeNode?, right: TreeNode?) {
        self.val =  val
        self.left = left
        self.right = right
    }
}


class LCTreeController: TCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "TREE"
        /*
             10
            /   \
           5     6
          / \   / \
         3   4 7   8
         */
        let root = createTree()
        var res = [Int]()
//        preOrder(root: root, res: &res)
//        print(res)
        
        let rest = inorderTraversal(root)
        print(rest)


        let label = UILabel()
        label.text = "ddd"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didClickOneClickArrival)))
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didClickOneClickArrival)))
        label.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        view.addSubview(label)
    }

    @objc func didClickOneClickArrival() {
        print("ddddd")
    }
    
    func createTree() -> TreeNode {
        let leftleft = TreeNode(val: 3)
        let leftright = TreeNode(val: 4)
        let left = TreeNode(val: 5, left: leftleft, right: leftright)
        
        let rightleft = TreeNode(val: 7)
        let rightright = TreeNode(val: 8)
        let right = TreeNode(val: 6, left: rightleft, right: rightright)
        let root = TreeNode(val: 10, left: left, right: right)
        return root
    }
    
    // MARK: - 前序遍历
    func preOrder(root: TreeNode?, res: inout [Int]) {
        if let roo = root {
            res.append(roo.val)
        }
        if let lef = root?.left {
            preOrder(root: lef, res: &res)
        }
        if let rig = root?.right {
            preOrder(root: rig, res: &res)
        }
    }
    
    //前序遍历_迭代-根左右
    func preorderTraversal_ex(root: TreeNode?) -> [Int] {
        var res = [Int]()
        guard let root = root else { return res }
        
        var queue = [TreeNode]()
        var curr: TreeNode? = root
        while !queue.isEmpty || curr != nil {
            while curr != nil {
                res.append(curr!.val)
                queue.append(curr!)
                curr = curr?.left
            }
            
            curr = queue.removeLast()
            curr = curr?.right
        }
        
        return res
    }
    
   
    // 二叉树的层序遍历
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var queue: [TreeNode] = []
        guard let root = root else {
            return []
        }
        queue.append(root)
        var res: [[Int]] = []
        
        while !queue.isEmpty {
            var arr: [TreeNode] = []
            while !queue.isEmpty {
                let first = queue.removeFirst()
                arr.append(first)
            }
            
            var intArr: [Int] = []
            for node in arr {
                intArr.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(intArr)

        }
        return res
    }
    
    /// 二叉树的层序打印
    func levelPrint(root: TreeNode?) {
        guard let root = root else { return }
        
        var queue: [TreeNode] = [ root ]
        while !queue.isEmpty {
            let curr: TreeNode = queue.removeFirst()
            print("curr =", curr.val)
            if let left = curr.left {
                queue.append(left)
            }
            if let right = curr.right {
                queue.append(right)
            }
        }
    }
    
    /// 中序递归
    func inorder_digui(root: TreeNode?) {
        guard let root = root else { return }
        
        inorder_digui(root: root.left)
        print(root.val)
        inorder_digui(root: root.right)
    }
    
    /// 中序迭代- 左根右
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var res: [Int] = []
        guard let root = root else {
            return res
        }
        
        var queue: [TreeNode] = []
        var curr: TreeNode? = root
        while !queue.isEmpty || curr != nil {
            while let crr = curr {
                queue.append(crr)
                curr = crr.left
            }
            
            curr = queue.popLast()
            if let crr = curr {
                res.append(crr.val)
            }
            curr = curr?.right
        }
        
        return res
    }
    
    
    func inorderTraversal_kaoshi(root: TreeNode?) -> [Int] {
        guard let root = root else { return  [] }
        
        var res: [Int] = []
        var stack: [TreeNode] = []
        var curr: TreeNode? = root
        
        while !stack.isEmpty || curr != nil {
            while curr != nil {
                if let crr = curr {
                    stack.append(crr)
                }
                curr = curr?.left
            }
            
            curr = stack.popLast()
            if let crr = curr {
                res.append(crr.val)
            }
            curr = curr?.right
        }
        
        return res
    }
    
    
    /// 锯齿遍历
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        
        var res: [[Int]] = []
        var level = 0
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            var arr: [TreeNode] = []
            while !queue.isEmpty {
                if let first = queue.first {
                    arr.append(first)
                    queue.removeFirst()
                }
            }
            
            var intArr: [Int] = []
            for node in arr {
                if (level % 2) != 0 {
                    intArr.insert(node.val, at: 0)
                } else {
                    intArr.append(node.val)
                }
                
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(intArr)
            
            level += 1
        }
        
        return res
    }
    
    /// 翻转二叉树,   先翻转根节点，在递归翻转左右节点
    public func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return root
        }
        
        let tmp = root?.left
        root?.left = root?.right
        root?.right = tmp
        
        invertTree(root?.left)
        invertTree(root?.right)
        return root
    }
    
    // 二叉树的镜像
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        let left = root?.left
        let right = root?.right
        root?.left = mirrorTree(right)
        root?.right = mirrorTree(left)
        return root
    }
    
    
    /// 是否是镜像二叉树
    public func isMirrorTree(root: TreeNode?) -> Bool{
        guard let root = root else { return false }
        
        return p_isMirrorTree(left: root.left, right: root.right)
    }
    
    private func p_isMirrorTree(left: TreeNode?, right: TreeNode?) -> Bool {
        if (left == nil && right == nil) {
            return true
        }
        if left == nil || right == nil {
            return false
        }
        if left!.val != right!.val {
            return false
        }
        
        if let lef = left, let rig = right {
            if lef.val != rig.val {
                return false
            }
            // 这步是关键，左右节点都递归是镜像的
            return p_isMirrorTree(left: lef.left, right: rig.right) &&
                p_isMirrorTree(left: lef.right, right: rig.left)
        }
        
        return false
    }

    /// 另一棵树的子树
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
       guard let root = root else { return false }
       guard let subRoot = subRoot else { return false }

       return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot) || isSameTree(root, subRoot)
    }
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil {
            return false
        }
        
        return (p?.val == q?.val) && isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
    
    func getMaxHeight(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var maxHeight = 0
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            maxHeight = max(maxHeight, getMaxHeight(node))
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        
        return maxHeight
    }

    // MARK: -
    var parentmap:[Int: TreeNode?] = [:]
    
    private func dfs_lowest(root: TreeNode?) {
        if let lef = root?.left {
            parentmap[lef.val] = root;
            dfs_lowest(root: lef)
        }
        if let rig = root?.right {
            parentmap[rig.val] = root
            dfs_lowest(root: rig)
        }
    }
    
    /// 最近公共祖先 
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || root === p || root === q {
            return root
        }
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left == nil, right == nil {
            return nil
        }
        if left == nil {
            return right
        }
        if right == nil {
            return left
        }
        return root // if(left != null and right != null)
    }
    
    // MARK: - 求树的高度
    func maxDepth(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        let left = maxDepth(root: root?.left)
        let right = maxDepth(root: root?.right)
        return max(left, right) + 1
    }
    
    func getMaxHeight(root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        let left = getMaxHeight(root: root.left)
        let right = getMaxHeight(root: root.right)
        return max(left, right) + 1;
    }
    
    
    // 110. 平衡二叉树
    /*给定一个二叉树，判断它是否是高度平衡的二叉树。
     本题中，一棵高度平衡二叉树定义为：
     一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1 。*/
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true // 如果当前树为空，理所当然是平衡二叉树
        }
        
        // 不为空，求出左右子树的高度，求高度差
        let leftHeight = maxDepth(root: root.left)
        let rightHeight = maxDepth(root: root.right)
        if abs(leftHeight - rightHeight) > 1 {
            //若高度差的绝对值大于1，就不是平衡二叉树，返回false
            return false
        }
        
        return isBalanced(root.left) && isBalanced(root.right)
    }
    
    func isBalanceTree(root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        let leftHeight = getMaxHeight(root: root.left)
        let rightHeight = getMaxHeight(root: root.right)
        if abs(leftHeight - rightHeight) > 1 {
            return false
        }
        
        return isBalanceTree(root: root.left) && isBalanceTree(root: root.right)
    }
    
    /// 最小深度，DFS
    func minDepth(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        if root?.left == nil && root?.right == nil {
            return 1
        }
        
        var depth = Int.max
        if let left = root?.left {
            depth = min(minDepth(root: left), depth)
        }
        if let right = root?.right {
            depth =  min(minDepth(root: right), depth)
        }
        return depth + 1
    }
    
    /// 最小深度，AFS
    func minDepthAFS(root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var level = 1
        var queue: [TreeNode] = []
        queue.append(root)
        
        while !queue.isEmpty {
            for _ in 0..<queue.count {
                let curr = queue.removeFirst()
                if curr.left == nil && curr.right == nil {
                    return level
                }
                
                if let left = curr.left {
                    queue.append(left)
                }
                if let right = curr.right {
                    queue.append(right)
                }
            }
            
            level += 1
        }
        return level
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        return isMirrorTree(left: root?.left, right: root?.right)
    }
    func isMirrorTree(left: TreeNode?, right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        if left == nil || right == nil {
            return false
        }
        
        return (left?.val == right?.val) &&
        isMirrorTree(left: left?.left, right: right?.right) &&
        isMirrorTree(left: left?.right, right: right?.left)
    }
    
    
    // 最低公共祖先
    func lowestCommonAncestor2(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || root === p || root === q {
            return root
        }
        
        let left = lowestCommonAncestor2(root?.left, p, q)
        let right = lowestCommonAncestor2(root?.right, p, q)
        if left != nil && right != nil {
            return root
        }
        return left != nil ? left : right
    }
    
    // 合并2个二叉树, 思路真牛逼
    func mergeTwoTrees(tree1: TreeNode?, tree2: TreeNode?) -> TreeNode? {
        guard let tree1 = tree1 else {
            return tree2
        }
        
        guard let tree2 = tree2 else {
            return tree1
        }
        
        let newNode = TreeNode(val: tree1.val + tree2.val)
        newNode.left = mergeTwoTrees(tree1: tree1.left, tree2: tree2.left)
        newNode.right = mergeTwoTrees(tree1: tree1.right, tree2: tree2.right)
        return newNode
    }
    
    // 257. 二叉树的所有路径
    var list = [String]()
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        let path: String = ""
        binaryTreePathsHelper(root: root, path: path)
        return list
    }
    
    func binaryTreePathsHelper(root: TreeNode?, path: String) {
        guard let root = root else { return }
        
        var tmpPath = path
        tmpPath += String(root.val)
        if root.left == nil, root.right == nil {
            list.append(tmpPath)
        } else {
            tmpPath += "->"
            binaryTreePathsHelper(root: root.left, path: tmpPath)
            binaryTreePathsHelper(root: root.right, path: tmpPath)
        }
    }
    
    //二叉树中的最大路径和
    var maxSum = Int.min
    func binaryTreeMaxPaths(_ root: TreeNode?) -> [String] {
        var sum = 0
        binaryTreePathsHelper2(root: root, sum: &sum)
        return list
    }
    
    func binaryTreePathsHelper2(root: TreeNode?, sum: inout Int) {
        guard let root = root else { return }
        
        var tmp = sum
        tmp += root.val
        if root.left == nil, root.right == nil { // 叶子节点
            if tmp > maxSum {
                maxSum = tmp
            }
        } else {
            binaryTreePathsHelper2(root: root.left, sum: &tmp)
            binaryTreePathsHelper2(root: root.right, sum: &tmp)
        }
    }
}

extension LCTreeController {
    
    // 右视图
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else {
            return []
        }
        
        var queue = [TreeNode]()
        queue.append(root)
        
        var res = [Int]()
        while !queue.isEmpty {
            
            var arr = [TreeNode]()
            while !queue.isEmpty {
                let head = queue.removeFirst()
                arr.append(head)
            }
            
            for node in arr {
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            var last: TreeNode = arr.last!
            res.append(last.val)
        }
        
        return res
    }
    
    // 求根到叶子节点数字之和 -- DFS
    func sumNumbers(_ root: TreeNode?) -> Int {
        var sum = 0
        return dfs_tree(root: root, preval: &sum)
    }
    func dfs_tree(root: TreeNode?, preval: inout Int) -> Int {
        guard let root = root else {
            return 0
        }
        
        var sum = preval * 10 + root.val
        if root.left == nil && root.right == nil {
            return sum
        } else {
            return dfs_tree(root: root.left, preval: &sum) + dfs_tree(root: root.right, preval: &sum)
        }
    }
    
    //  路径总和 --给你二叉树的根节点 root 和一个表示目标和的整数 targetSum
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        
        // 叶子节点了
        if root.left == nil && root.right == nil {
            return targetSum == root.val
        } else {
            return hasPathSum(root.left, targetSum - root.val) ||
            hasPathSum(root.right, targetSum - root.val)
        }
    }
    
    
    // 124. 二叉树中的最大路径和 -
    //  https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/
    static var ans = Int.min
    static func maxPathSum(root: TreeNode?) -> Int {
        maxPath_dfs(root: root)
        return ans
    }
    static func maxPath_dfs(root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        //左右子树提供的最大路径和
        let left = maxPath_dfs(root: root.left)
        let right = maxPath_dfs(root: root.right)
        
        //当前子树内部的最大路径和
        let insum = root.val + left + right
        ans = max(ans, insum) //挑战最大纪录
        
        //当前子树对外提供的最大和
        let outsum = root.val + max(0, max(left, right))
        return max(outsum, 0)
    }
    
    
    // 展开为链表 -顺序和先序遍历相同
    func flatten(_ root: TreeNode?) {
        var res = [TreeNode]()
        var stack = [TreeNode]()
        var curr: TreeNode? = root;
        
        while !stack.isEmpty || curr != nil {
            while curr != nil {
                res.append(curr!)
                stack.append(curr!)
                curr = curr?.left
            }
            
            let crr = stack.removeLast()
            curr = crr.right
        }
        
        let list = TreeNode(val: -1)
        var nxt: TreeNode! = list
        for node in res {
            node.left = nil
            nxt.right = node
            nxt = nxt.right
        }
        
    }
}
