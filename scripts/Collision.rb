module Collision
   def simple_collision?(a, b)
     if (a.Movement.x <= b.Movement.x and (a.Movement.x + a.Movement.width) > b.Movement.x) and (a.Movement.y <= b.Movement.y and (a.Movement.y + a.Movement.height) > b.Movement.y)
       return true
     else
       return false
     end
   end

   def collision?(a, b)
     if (simple_collision?(a, b) or simple_collision?(b, a))
       return true
     else
       return false
     end
   rescue
     return false
     end


end
