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


 def get_sorted_elements(category)         # This method returns all elements sorted by the alphabetic order or by atomic_weight
      str = ""
      element=CSV.parse(File.read("elements.txt"))
      if category == 0
          sorted_array = element.sort_by{|arr| arr[category].to_s}
      elsif (category == 2)
          sorted_array = element.sort_by{|arr| arr[category].to_i}
      end
      for row in 0..sorted_array.length-1 do
          for column in 0..5 do
              str += sorted_array[row][column].to_s.ljust(20)
          end
          str += "\n"
       end
       str += "\n"
       str
 end
 def print_sorted_elements(category)
     print get_sorted_elements(category)
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
       element = CSV.read('elements.txt')
       change = element.find {|item| item[0] =~ /#{original}/}
       change[0] = change_name
       change[1] = change_symbol
       change[2] = change_num
       change[3] = change_weight
       change[4] = change_state
       change[5] = change_type

       CSV.open('elements.txt', 'w') do |csv|
          element.each do |item|
             csv << item
          end
       end
 end

end                  # End of class Catalog



elmnt = Catalog.new
if ARGV[0] == "all"
    elmnt.print_elements
end
if ARGV[0] == "search_by_name" 
    elmnt.print_element_by_name(ARGV[1])
end
if ARGV[0] == "search_by_symbol"
    elmnt.print_elements_by_type(ARGV[1], 1)
end
if ARGV[0] == "search_by_atomic_num"
    elmnt.print_element_by_atomic_num(ARGV[1])
end
if ARGV[0] == "search_by_atomic_weight"
    elmnt.print_elements_by_AtomicWeight(ARGV[1], ARGV[2])
end
if ARGV[0] == "search_by_state" 
    elmnt.print_elements_by_state(ARGV[1])
end
if ARGV[0] == "search_by_type"
    elmnt.print_elements_by_type(ARGV[1])
end
if ARGV[0] == "add_element"
     elmnt.add_elem(ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6])
end
if ARGV[0] == "update_element"
     elmnt.update_elem(ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6], ARGV[7])
end
if ARGV[0] == "sort_by_name"
     elmnt.print_sorted_elements(0)
end
if ARGV[0] == "sort_by_atomic_num"
     elmnt.print_sorted_elements(2)
end
