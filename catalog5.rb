require 'csv'

class Element
def initialize(name, symbol, num, weight, state, type)
      @name = name
      @symbol = symbol
      @num = num
      @weight = weight
      @state = state 
      @type = type
 
end
attr_accessor :name, :symbol, :num, :weight, :state, :type

def to_s

                    # str += element[row][column].to_s.ljust(20)
                 str = ''
                 str += @name.to_s.ljust(20)
                 str += @symbol.to_s.ljust(20)
                 str += @num.to_s.ljust(20)
                 str += @weight.to_s.ljust(20)
                 str += @state.to_s.ljust(20)
                 str += @type.to_s.ljust(20)
       str

end

end    #end of class Element


class Catalog
  def  initialize
       @elements = load_elements
  end 
 def load_elements
      elements = Array.new 
         CSV.open('elements.txt', 'r').each do |row|
           element = Element.new(row[0], row[1], row[2], row[3], row[4], row[5])
           elements << element
       end 
       elements
 end
 def print_titles
     strng = ""
     str = ["Element Name", "Symbol",  "Atomic Number",  "Atomic Weight", "State", "Type"]
     str.each do |item|
        strng += item.ljust(20) 
     end
     strng += "\n"
     print strng
 end



 def print_elements 
     print_titles
     @elements.each do |element|
        puts element.to_s
     end 
 end


 def print_sorted_elements(category)        
      if category == 1
          sorted_array = @elements.sort_by{|element| element.name.to_s}
      elsif category == 2 
          sorted_array = @elements.sort_by{|element| element.symbol.to_s}
      elsif category == 3 
          sorted_array = @elements.sort_by{|element| element.num.to_i}
      elsif category == 4 
          sorted_array = @elements.sort_by{|element| element.weight.to_f}
      elsif category == 5 
          sorted_array = @elements.sort_by{|element| element.state.to_s}
      elsif category == 6 
          sorted_array = @elements.sort_by{|element| element.type.to_s}
      end    
      print_titles
      sorted_array.each do |item|
            puts item.to_s
      end
 end
 def print_element_by_name(elem)
     print_titles
     @elements.each do |element|
         if elem == element.name
             puts element.to_s
         end
     end
 end

 def print_element_by_atomic_num(elem)
      print_titles
      @elements.each do |element|
         if elem == element.num
             puts element.to_s
         end
       end
 end 
 def print_elements_by_AtomicWeight(elem1, elem2)
      print_titles
      @elements.each do |element|
         if element.weight.to_f.between?(elem1.to_f, elem2.to_f)
             puts element.to_s
         end
      end
       
 end 

 def print_elements_by_state(elem)
      print_titles
      @elements.each do |element|
          if elem == element.state
              puts element.to_s
          end
      end
 end 


 def print_elements_by_type(elem)
      print_titles
      @elements.each do |element|
          if elem == element.type
              puts element.to_s
          end
      end
 end

 def add_elem (name, symbol, atomic_num, atomic_weight, state, type)
      CSV.open('elements.txt', 'a') do |csv|
           csv << [name, symbol, atomic_num, atomic_weight, state, type]
      end
 end
 def update_elem(original, change_name, change_symbol, change_num, change_weight, change_state, change_type)
    @elements.each do |element|
      if original == element.name
        element.name = change_name
        element.symbol = change_symbol
        element.num = change_num
        element.weight = change_weight
        element.state = change_state
        element.type = change_type
      end
    end

       CSV.open('elements.txt', 'w') do |csv|
          @elements.each do |element|
             csv << [element.name, element.symbol, element.num, element.weight, element.state, element.type]
          end
       end
 end

end                  # End of class Catalog



elmnt = Catalog.new
if ARGV[0] == "all"
    elmnt.print_elements

elsif ARGV[0] == "search_by_name" 
    elmnt.print_element_by_name(ARGV[1])

elsif ARGV[0] == "search_by_symbol"
    elmnt.print_elements_by_type(ARGV[1], 1)

elsif ARGV[0] == "search_by_atomic_num"
    elmnt.print_element_by_atomic_num(ARGV[1])

elsif ARGV[0] == "search_by_atomic_weight"
    elmnt.print_elements_by_AtomicWeight(ARGV[1], ARGV[2])

elsif ARGV[0] == "search_by_state" 
    elmnt.print_elements_by_state(ARGV[1])

elsif ARGV[0] == "search_by_type"
    elmnt.print_elements_by_type(ARGV[1])

elsif ARGV[0] == "add_element"
     elmnt.add_elem(ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6])

elsif ARGV[0] == "update_element"
     elmnt.update_elem(ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6], ARGV[7])

elsif ARGV[0] == "sort_by_name"
     elmnt.print_sorted_elements(1)

elsif ARGV[0] == "sort_by_symbol"
     elmnt.print_sorted_elements(2)

elsif ARGV[0] == "sort_by_atomic_num"
     elmnt.print_sorted_elements(3)

elsif ARGV[0] == "sort_by_atomic_weight"
     elmnt.print_sorted_elements(4)

elsif ARGV[0] == "sort_by_state"
     elmnt.print_sorted_elements(5)

elsif ARGV[0] == "sort_by_type"
     elmnt.print_sorted_elements(6)
end
