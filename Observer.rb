class Observer
   def initialize(subject)
      @subject = subject
   end
   def update(args)
   end
end

class StoneObserver < Observer
end