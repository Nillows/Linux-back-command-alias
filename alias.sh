# HOW TO USE
# PLACE THIS CODE BLOCK SOMEWHERE IN YOUR '.bashrc' FILE AND THEN EXECUTE 'source ~/.bashrc' OR OPEN A NEW TERMINAL
# execute alias 'back' to go back to previous directory. This alias is designed to work with and compliment the standard command 'cd ..' 



# Creates a history array containing directories I have visited
# edits the 'cd' command to also perform a 'PWD' call and append to pathHistory array
# establishes the 'back' command to perform the proper 'cd' command to reverse your working traversal path so far
# deletes the last entry in the history array to ensure the history array remains accurate from $HOME to $PWD
# automatically increments and decrements position in pathHistory array.
# execute alias 'back' to go back to previous directory. This command is meant to work with and compliment the standard command 'cd ..' 

# Initialize the pathHistory array and arrayPosition
pathHistory=("$HOME")
arrayPosition=0

# Function to override the 'cd' command
cd() {
    builtin cd "$@" && {  # Perform the actual cd operation
        PWD=$(pwd)       # Get the new directory path
        pathHistory+=("$PWD") # Add the new path to pathHistory
        ((arrayPosition++)) # Increment the position
    }
}

# Function to go back to the previous directory and truncate history
back() {
    if [[ $arrayPosition -gt 0 ]]; then
        ((arrayPosition--)) # Decrement the position
        builtin cd "${pathHistory[$arrayPosition]}" || ((arrayPosition++)) # Go to the previous directory OR correct position on failure
        unset pathHistory[arrayPosition+1] # Remove the last entry in pathHistory
    else
        echo "No previous directory in history."
    fi
}
