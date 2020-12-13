class Node
    attr_accessor :value, :left, :right

    def initialize(value=nil,left=nil,right=nil)
        @value=value
        @left = left
        @right = right
    end

end

def minValueNode(node)
    current = node
    while current.left
        current = current.left
    end
    return current
end


class Tree
    attr_accessor :array, :root
    def initialize(array=nil, root=nil)
        @array = array.sort.uniq
        @root = build_tree(@array)
        
    end

    def build_tree(array)
    return nil if array.empty?

    middle = (array.size - 1) / 2
    root_node = Node.new(array[middle])

    root_node.left = build_tree(array[0...middle])
    root_node.right = build_tree(array[(middle + 1)..-1])

    root_node
    end

    

    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert( value, node = root)
        if node == nil 
            Node.new(value)
        else
            if node.value == value 
                return node 
            elsif node.value < value 
                node.right = insert( value, node.right,) 
            else 
                node.left = insert( value, node.left) 
            end
        return node
        end
            
    end

    def delete(value, node = root)
        if node == nil
            return node
        end
        if  value < node.value
            node.left = delete(value, node.left)
        elsif value > node.value
            node.right = delete(value, node.right)
        else
            if node.left == nil
                temp = node.right
                node = nil
                return temp
            elsif node.right == nil
                temp = node.left
                node = nil
                return temp
            end
            temp = minValueNode(node.right)
            node.value = temp.value
            node.right = delete(temp.value, node.right)
        end
        return node 
    end

    def find(value, node = root)

        if node == nil
            return nil
        elsif value == node.value
            return node
        
        end
        
        if value > node.value
            find(value, node.right)
        elsif value < node.value
            find(value, node.left)
        end
        
    end

    def levelOrder(node = root)
        queue = []
        temp_node = node
        result = []
        while temp_node != nil
            result.push(temp_node.value)
            if temp_node.left
                queue.push(temp_node.left)
            end
            if temp_node.right
                queue.push(temp_node.right)
            end
            
            dequeued = queue[0]
            queue.shift
            temp_node = dequeued
        end
        return result
    end

    def inorder(node = root, array = [])
        return if node == nil
        
        inorder(node.left, array)
        array << node.value
        inorder(node.right, array)
        return array
    end

    def preorder(node = root)
        return if node == nil

        print "#{node.value} "
        preorder(node.left)
        preorder(node.right)
    end

    def postorder(node = root)
        return if node == nil

        postorder(node.left)
        postorder(node.right)
        print "#{node.value} "
    end

    def height(node )
        if node.is_a? Integer
            node = find(node)
        end

        if node == nil
            return -1 
        end
        lh = height(node.left)
        rh = height(node.right)
        if lh > rh
            return lh + 1
        else 
            return rh + 1
        end
    end

    def depth(value, node = root, edge = 0)
        if node == nil
            return nil
        elsif value == node.value
            return edge
        
        end
        
        if value > node.value
            edge += 1
            depth(value, node.right, edge)
        elsif value < node.value
            edge +=1
            depth(value, node.left, edge)
        end
    end

    def balanced?(node = root)
        if node == nil
            return true
        end

        lh = height(node.left)
        rh = height(node.right)
        

        if (lh-rh).abs <= 1 && balanced?(node.right) && balanced?(node.left)
            return true
        end
        return false
    end

    def rebalance
        self.array = inorder
        self.root = build_tree(@array)
    end


end



array = Array.new(15) { rand(1...100) }
tree = Tree.new(array)
puts tree.balanced?
puts
puts tree.inorder
puts
puts tree.levelOrder
puts
puts tree.postorder
puts
puts tree.preorder
5.times do 
    tree.insert(rand(100...150))
end

puts tree.balanced?
tree.rebalance
puts tree.balanced?
puts tree.balanced?


print tree.inorder
puts

print tree.levelOrder
puts
puts tree.postorder
puts
puts tree.preorder