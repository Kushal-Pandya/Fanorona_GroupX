class Observer
   def initialize(subject)
      @subject = subject
   end
   def update(args)
   end
end

class StoneObserver < Observer
	def initialize(observers)
		@observers = nil
	end
	def register_observer(observer)
	end
	def unregister_observer(observer)
	end
	def get_state()
	end
	def set_state()
	end
end