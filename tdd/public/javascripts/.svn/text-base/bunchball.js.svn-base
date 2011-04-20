// Logs the actions to Bunchball from the client (low security) API
// sessionKey: The response from user.login to Bunchball
// action:  The string with the action name (the convention is OBJECT_VERB e.g. VIEWER_SIGNUP_FACEBOOK)
// value:   This is the integer value that is the additional parameter that we could assign for the action 
//          Default is 0. Must be a number. This value is what enables you to create leaderboards, see if user 
//          has met a certain criteria, and do running total calculations. If this action represents Inviting 
//          Friends, you could pass a value of 3 in to indicate that the user invited 3 friends. If the action represents Watching a Video, you could pass in the time in seconds that the user watched the video. If the action represents Playing a Game, you could pass in the score.

function logClientAction (action, value){
	nitro.callAPI("method=user.clientLogAction&sessionKey=&tags=" + action + "&value=" + value); 
}

function userLoginForBB(api_key, user_id) {
    	nitro.callAPI("method=user.login&apiKey=" + api_key + "&userId=" + user_id, processLoginInfo); 
}


// Callback method for user.login
function processLoginInfo() {
    
}