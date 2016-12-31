
This issue was very hard to troubleshoot and google-ing it lead to nowhere! It may belong in the elm-lang/html package instead. I decided to report it here because the symptoms are URL navigation related. 

The behavior is browser specific.  The hardest to troubleshoot is Chrome.

__Code example__  
I was able to isolate the issue:  
https://github.com/rpeszek/elm-double-navigate.git  

There are 2 buttons, one outside of Http.form and the other inside Http.form. Both trigger Navigate.newUrl.  Button inside the form misbehaves.

Run it in Chrome either using elm-reactor pointing to src/Main.elm or compiled (elm-run.html).
Click on both buttons several times, examine the console to see what happens.

__Steps (in Chrome):__  
1.  On first "url2" button click the page reloads (the form is actually submitted).
I found this behavior intermittent, I have seen the behavior in which this does not happen, but the real issue describe in (2) still happens.

2.  On consecutive clicks, the ```
Location -> Msg 
``` function (first parameter of Navigation.program) is called twice!  
And the full chain of program calls is triggered as well.

3. Try different sequences of clicking the "Root" and "Url2" buttons to see how URL is intermittently dispatched to different hash-places.

![Console picture](console_log.png)

__Other factors:__  
If clicking on a button makes HTTP request first and then Navigation.newUrl is invoked, everything works fine!  No page refresh, navigation function is called only once, everything seems to work as expected.

__Other browsers:__  
Behave differently, Safari tends to submit the form (refresh the page) every time. Did not test any other browser.

__Cause:__  
Placing the button that triggers Navigation.newUrl inside Http.form (with or without Http.fieldset) causes the issue.  Using Naviation.modifyUrl causes the same problem.

__Real life:__  
Think CRUD with an edit form (U-view) that goes to R-view url when Cancel is clicked.  If cancel button is part of the form clicking on it will intermittently stay on the U-view or go sometimes to the R-view. 

__Work-around:__  
Keep the button outside of Http.from

__New Bug:__  
Behavior in Elm 0.17 and Navigation 1.0 was different,  I have seen updateUrl invoked redundantly but the URL was always correct.  

__System info:__  
Elm Version: 0.18  
OS:  Mac 10.11.6  
Chrome version 54.0.2840.98 (64-bit)  
Currently latests elm Html, Navigation libraries.
