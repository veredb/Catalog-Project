require 'csv'
class Catalog
 def initialize(element)
     @element = element
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

 def get_elements         # This method returns all elements
     str = ""
     if !File.readable?("elements.txt")
         str +=  "File doesn't exist" + "\n"
     else
         element=CSV.parse(File.read("elements.txt"))
               for row in 0..element.length-1 do 
                 for column in 0..5 do
                     str += element[row][column].to_s.ljust(20)
                 end
                 str += "\n"
               end
      end
      str
 end


 def print_elements 
     print_titles
     print get_elements
 end


 def get_sorted_elements(category)         # This method returns all elements sorted by the alphabetic order or by atomic_weight
      str = ""
      element=CSV.parse(File.read("elements.txt"))
      if category == 0
          sorted_array = element.sort_by{|arr| arr[0].to_s}
      elsif (category == 1)
          sorted_array = element.sort_by{|arr| arr[1].to_s}
      elsif (category == 2)
          sorted_array = element.sort_by{|arr| arr[2].to_i}
      elsif (category == 3)
          sorted_array = element.sort_by{|arr| arr[3].to_f}
      elsif (category == 4)
          sorted_array = element.sort_by{|arr| arr[4].to_s}
      elsif (category == 5)
          sorted_array = element.sort_by{|arr| arr[5].to_s}
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
     print_titles
     print get_sorted_elements(category)
 end
 def get_element_by_name
     str =""
     el = CSV.read("elements.txt")
     item =   el.find do |p|
         p[0].include?(@element) unless p.length == 0
     end
     for i in 0..5 do
         str += item[i].ljust(20)
     end
     str += "\n"
     return str
                
 end
 def print_element_by_name
      print_titles
      print get_element_by_name
 end 

 def get_element_by_atomic_num(element1)
     str =""
     el = CSV.read("elements.txt")
     item =   el.find do |p|
        p[2].include?(element1) unless p.length == 0
     end
     for i in 0..5 do
         str += item[i].ljust(20)
      end
      str += "\n"
      return str
                
 end
 def print_element_by_atomic_num(element1)
      print_titles
      print get_element_by_atomic_num(element1)
 end 
 def get_elements_by_AtomicWeight(element1, element2)
      str =""
      el = CSV.read('elements.txt')
      elem = el.find_all do |p|
          p[3].to_f.between?(element1.to_f, element2.to_f) 
      end
       for row in 0..elem.length-1 do
          for column in 0..5 do
               str += elem[row][column].ljust(20)
          end
          str += "\n"
        end
        str += "\n"
        str 
 end
 def print_elements_by_AtomicWeight(element1, element2)
      print_titles
      print get_elements_by_AtomicWeight(element1, element2)
 end 
 def get_elements_by_type(element1, category)
      str =""
      el = CSV.read('elements.txt')
      elem = el.find_all do |p|
          p[category].include?(element1.to_s) unless p.length==0    #array_num is the category number (state=4 type=5)
      end
       for row in 0..elem.length-1 do
          for column in 0..5 do
               str += elem[row][column].ljust(20)
          end
          str += "\n"
        end
        str += "\n"
        str 
 end
 def print_elements_by_type(element1, category)
      print_titles
      print get_elements_by_type(element1, category)
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



elmnt = Catalog.new(ARGV[1])
if ARGV[0] == "all"
    elmnt.print_elements

elsif ARGV[0] == "search_by_name" 
    elmnt.print_element_by_name

elsif ARGV[0] == "search_by_symbol"
    elmnt.print_elements_by_type(ARGV[1], 1)

elsif ARGV[0] == "search_by_atomic_num"
    elmnt.print_element_by_atomic_num(ARGV[1])

elsif ARGV[0] == "search_by_atomic_weight"
    elmnt.print_elements_by_AtomicWeight(ARGV[1], ARGV[2])

elsif ARGV[0] == "search_by_state" 
    elmnt.print_elements_by_type(ARGV[1], 4)

elsif ARGV[0] == "search_by_type"
    elmnt.print_elements_by_type(ARGV[1], 5)

elsif ARGV[0] == "add_element"
     elmnt.add_elem(ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6])

elsif ARGV[0] == "update_element"
     elmnt.update_elem(ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6], ARGV[7])

elsif ARGV[0] == "sort_by_name"
     elmnt.print_sorted_elements(0)

elsif ARGV[0] == "sort_by_symbol"
     elmnt.print_sorted_elements(1)

elsif ARGV[0] == "sort_by_atomic_num"
     elmnt.print_sorted_elements(2)

elsif ARGV[0] == "sort_by_atomic_weight"
     elmnt.print_sorted_elements(3)

elsif ARGV[0] == "sort_by_state"
     elmnt.print_sorted_elements(4)

elsif ARGV[0] == "sort_by_type"
     elmnt.print_sorted_elements(5)
end
