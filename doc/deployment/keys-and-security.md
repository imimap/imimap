# News
Rails 5.2. has some changes in the key/secret handling:

https://edgeguides.rubyonrails.org/5_2_release_notes.html#credentials

- added MASTER_KEY to travis encrypted environment variables.


# Overview

Several Steps in the Deployment Process and Rails itself need secret keys
or other forms of credentials. This file doesn't contain the actual passwords,
I've replaced them with <geheim>.


## Docker repository

The Build/Deployment uploads the imimap images to the docker repository
and needs username and password for this. Include them in .travis.yml
encrypted by calling:

travis encrypt DOCKER_USERNAME=imimap --add
travis encrypt DOCKER_PASSWORD=<geheim> --add  

generated keys:

+  - secure: to+AQt8UImBpUZgPf9g3Nxw8kzShVzO1zSRAFBOJbqgbqOCJdOs8o0IBKNin4enlexUE7lH9VJIE4p1o00oowcTxKJTuBqbTLVpCCCNDlAAzd1dNwAEucGcXVK5mLyy1KEPwecF00vNwubKMuMeLb0r0ulRFyjRTg2WEGi7Wi1bi/7hzw0oYYQgRRHNme186ve1qExsNFycGD8VvQ/tHY4HlAbE/KSvlPfGjOtFS+r8VXDu5/oFgrCX+1s5QiZZoBbvzRfGFUbIdzoMZfyb/FVzsy3X3Zl/OXpbbaSO+dBKWI2c2yfI2ILFm6oCzAvYBPLh8nu8jtDBE50kCtJkxZ6u9ZYhsF1byG//doN6Ii8La+TVYfM4Z2qmunOTAeikgWq4eCCL4ZQE5kdjvantORxvh4CuoENKq09ydml8WbDCDsr57v2BZ0TmSqfW1I7cvyanhuY8XplXYFvp2StQxWA2vfNuwfUfsx8a9j/Id7fNSv6z5XJItQPW8LOnrc3dyX0avIK2bdWSBA72xxrhJ/xZgCg5CHCbUT1Q7zP3GjofvNEPjs7UnzXJAfm+cerCZZxa4wy1GkCNd/4uD8XCpHzim/mFvDsyROK8myU8Fe41wMkK27erL3ioBovg81Py71CDodBJT3dCO8mKZ9NCdGvaLGGPJ8gh5QfvfSvLmmEM=
+  - secure: PXdWY67qu+/7djK6gqmm7NRoaC8DUAmhooJmSHfDo3h7uBcGFAhMezy3rtw7UUQoOGEVqdzMuasmxOvj6DRRLFFqJ+AJZ7ctItdc1ZqnbO7Hlq3uVxd23FjPonWnwnVbzKenV/4DUMG9mwvND8BnSNazi9eR1L/KBlWNHcpNbRt/BY7+pmfmX7/5FVjN0p/Glm2sZOKJS4ADx0Ro/RHflVaxgh1lj/awMOlyxEQt6RKgzObgJ7B2kFcU4lP3NqkdpnM8LYuaWBno79ikhvDq+OMtZBMiNDx73p3cbkvT67qXzzYPwTLSh/3Udqqv7PiNSuQAqMvQISE9YXm9AsCjPq043E4Cg5EU51dLNY8c2quYasf2S0wXSVxCDl4ZUnht7yP5KaAGhE5lGhjhnKCwtLTWSqEGWD3fccMrVDzdnVE7OxCl0YpcdjC8F23ecLiPfQCfaH3kEMnHdMavy8jaiqXpYSh2stIVFh77ek125EfgTzZTji/IIxKTi+UupWiKqtkO7VFCeNHeSxmG2AJ7LoMulW+oaYNJxLwrKhVAvrO1Nb6d6Hpqsnc45+4HhdPXQTkx3Dq56G22RK5sqkXbtdP9uXykxhGb7Suzqw5JbjAe6uar6UgKWNazKqLsXhJhjTkAkzJ9nJA5WjChNSb3AlDPsewTcemoHaAY3APw9/Q=

## Travis Environment variables
see https://travis-ci.org/imimap/imimap/settings

DEPLOY_FROM_BRANCH  
DEPLOYMENT_PIPELINE  
encrypted_f259336567b4_iv - key for decrypting ssh keys
encrypted_f259336567b4_key - key for decrypting ssh keys    
LDAP    - the LDAP connect string transferred to the docker container
RAILS_MASTER_KEY - the RAILS_MASTER_KEY connect string transferred to the docker container

## ssh keys for sshing to deployment servers
The keys are included in an encrypted file in the repository:

ssh_keys.tar.enc

see https://docs.travis-ci.com/user/encrypting-files/

Search for   "openssl aes-256-cbc" to find the spots in the deployment scripts
where they are decrypted.
