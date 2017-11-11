class Subject
   def initialize(view)
      @observers = []
	  @viewModel = view
      @state = nil
   end
   def register_observer(observer)
      @observers << observer
   end
   def unregister_observer(observer)
      @observers -= observer #no idea if this is correct
   end
   def get_state()
       #return @state
	   
	   #
   end
   def set_state()
      #what even actually goes here? there has to be an input for this to even make sense, right?
   end
end