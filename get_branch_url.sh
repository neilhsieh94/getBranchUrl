#!/bin/bash

##############################################################
# README
#
# Quick Set Up
# 1. Copy this file into your home directory
#    a) In terminal: cd ~
#    b) To copy, open the current folder in finder,
#       In Terminal: open `pwd`
#    c) Copy and pasta in there
#
# 2. Open your .bash_profile
#    a) From anywhere in terminal, 
#       In Terminal: code ~/.bash_profile
#
# 3. Copy paste this in the last line
#
#    source ~/get_branch_url.sh
#
#    (this will allow you to run this file in all new terminals)
#
# 4. Restart your terminal and voila!
#
#
# To change name of function call, simply change the 
# function name below where indicated. Then restart your terminal.
# 
##############################################################
# Grabs git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

searchForLine() {
  filename='dev-options.js'

  arg1=$1

  while read line
  do
    # reading each line
    IFS=" "  #setting space as delimiter  
    read -ra eachLine <<<"$line" #reading str as an array as tokens separated by IFS  
    for i in "${eachLine[@]}"
    do
      if [[ $i == $arg1 ]]
        then
          local retval=$line
          echo $retval
      fi
    done
  done < $filename

}

findInString() {
  arg1=$1 #string
  arg2=$2 #IFS
  arg3=$3 #array index

  IFS="$arg2"    
  read -ra ADDR <<<"$arg1" #reading str as an array as tokens separated by IFS  

  echo ${ADDR[$arg3]}
}

########## Change Function Name Here ##########
function getbranch() {
  local gitBranch=$(parse_git_branch)
  gitBranch=$(findInString "$gitBranch" "(" "1")
  gitBranch=$(findInString "$gitBranch" ")" "0")
  if [ `expr "$gitBranch" : '.*'` -ne "0" ]
    then


      local fullHubUrl
      local hyper
      local httpObj
      local hubsObj
      local finalUrl

      filename='dev-options.js'

      fullHubUrl=$(searchForLine "fullHubUrl:")

      read -ra urlArr <<<"$fullHubUrl" #reading str as an array as tokens separated by IFS  

      for word in "${urlArr[@]}"
        do 
          if [[ $word ==  *"http"* ]]
            then 
              fullHubUrl="${word:1:${#word}-2}"
          fi
      done


      if [[ $fullHubUrl == *"{"* ]]
        then
          local tempWord=$fullHubUrl
          hyper=$(findInString "$tempWord" "$" "0")

          local tempStr=$(findInString "$fullHubUrl" "{" "1")
          httpObj=$(findInString "$tempStr" "}" "0")
        else
          finalUrl=$fullHubUrl
      fi

      if [[ `expr "$httpObj" : '.*'` -ne "0" ]]
        then
          if [[ $httpObj == *"."* ]]
            then 
              hubsObj=$(findInString "$httpObj" "." "1")
            else 
              hubsObj=$httpObj
          fi
          local relUrl=$(searchForLine "$hubsObj:")
          relUrl=$(findInString "$relUrl" " " "1")
          relUrl=$(findInString "$relUrl" "''" "1")

          finalUrl="${hyper}${relUrl}"  
      fi
      echo "${finalUrl}?ufcc_onbrand_branch=${gitBranch}"

    else  
      echo "You're not on a git branch!"
  fi
  
}
