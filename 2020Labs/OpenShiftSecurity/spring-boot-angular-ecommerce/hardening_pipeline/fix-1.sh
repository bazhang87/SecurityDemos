###############################################################################
#
# MODIFIED Bash remediation role for the results of evaluation of profile xccdf_org.ssgproject.content_profile_stig-rhel7-disa 
# XCCDF Version:  1.2
#
# Evaluation Start Time:  2019-05-22T09:28:25
# Evaluation End Time:  2019-05-22T09:28:35
#
# This file was generated by OpenSCAP 1.2.17 using:
# 	$ oscap xccdf generate fix --result-id xccdf_org.open-scap_testresult_xccdf_org.ssgproject.content_profile_stig-rhel7-disa --template urn:xccdf:fix:script:sh xccdf-results.xml 
#
# This script is generated from the results of a profile evaluation.
# It attempts to remediate all issues from the selected rules that failed the test.
#
# How to apply this remediation role:
# $ sudo ./dsop-fix.sh
#

###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration'")

var_account_disable_post_pw_expiration="0"
# Function to replace configuration setting in config file or add the configuration setting if
# it does not exist.
#
# Expects arguments:
#
# config_file:		Configuration file that will be modified
# key:			Configuration option to change
# value:		Value of the configuration option to change
# cce:			The CCE identifier or '@CCENUM@' if no CCE identifier exists
# format:		The printf-like format string that will be given stripped key and value as arguments,
#			so e.g. '%s=%s' will result in key=value subsitution (i.e. without spaces around =)
#
# Optional arugments:
#
# format:		Optional argument to specify the format of how key/value should be
# 			modified/appended in the configuration file. The default is key = value.
#
# Example Call(s):
#
#     With default format of 'key = value':
#     replace_or_append '/etc/sysctl.conf' '^kernel.randomize_va_space' '2' '@CCENUM@'
#
#     With custom key/value format:
#     replace_or_append '/etc/sysconfig/selinux' '^SELINUX=' 'disabled' '@CCENUM@' '%s=%s'
#
#     With a variable:
#     replace_or_append '/etc/sysconfig/selinux' '^SELINUX=' $var_selinux_state '@CCENUM@' '%s=%s'
#
function replace_or_append {
  local default_format='%s = %s' case_insensitive_mode=yes sed_case_insensitive_option='' grep_case_insensitive_option=''
  local config_file=$1
  local key=$2
  local value=$3
  local cce=$4
  local format=$5

  if [ "$case_insensitive_mode" = yes ]; then
    sed_case_insensitive_option="i"
    grep_case_insensitive_option="-i"
  fi
  [ -n "$format" ] || format="$default_format"
  # Check sanity of the input
  [ $# -ge "3" ] || { echo "Usage: replace_or_append <config_file_location> <key_to_search> <new_value> [<CCE number or literal '@CCENUM@' if unknown>] [printf-like format, default is '$default_format']" >&2; exit 1; }

  # Test if the config_file is a symbolic link. If so, use --follow-symlinks with sed.
  # Otherwise, regular sed command will do.
  sed_command=('sed' '-i')
  if test -L "$config_file"; then
    sed_command+=('--follow-symlinks')
  fi

  # Test that the cce arg is not empty or does not equal @CCENUM@.
  # If @CCENUM@ exists, it means that there is no CCE assigned.
  if [ -n "$cce" ] && [ "$cce" != '@CCENUM@' ]; then
    cce="CCE-${cce}"
  else
    cce="CCE"
  fi

  # Strip any search characters in the key arg so that the key can be replaced without
  # adding any search characters to the config file.
  stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "$key")

  # shellcheck disable=SC2059
  printf -v formatted_output "$format" "$stripped_key" "$value"

  # If the key exists, change it. Otherwise, add it to the config_file.
  # We search for the key string followed by a word boundary (matched by \>),
  # so if we search for 'setting', 'setting2' won't match.
  if LC_ALL=C grep -q -m 1 $grep_case_insensitive_option -e "${key}\\>" "$config_file"; then
    "${sed_command[@]}" "s/${key}\\>.*/$formatted_output/g$sed_case_insensitive_option" "$config_file"
  else
    # \n is precaution for case where file ends without trailing newline
    printf '\n# Per %s: Set %s in %s\n' "$cce" "$formatted_output" "$config_file" >> "$config_file"
    printf '%s\n' "$formatted_output" >> "$config_file"
  fi
}

replace_or_append '/etc/default/useradd' '^INACTIVE' "$var_account_disable_post_pw_expiration" 'CCE-27355-7' '%s=%s'
# END fix for 'xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration'


###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_accounts_logon_fail_delay'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_accounts_logon_fail_delay'")


# Set variables
var_accounts_fail_delay="4"
# Function to replace configuration setting in config file or add the configuration setting if
# it does not exist.
#
# Expects arguments:
#
# config_file:		Configuration file that will be modified
# key:			Configuration option to change
# value:		Value of the configuration option to change
# cce:			The CCE identifier or '@CCENUM@' if no CCE identifier exists
# format:		The printf-like format string that will be given stripped key and value as arguments,
#			so e.g. '%s=%s' will result in key=value subsitution (i.e. without spaces around =)
#
# Optional arugments:
#
# format:		Optional argument to specify the format of how key/value should be
# 			modified/appended in the configuration file. The default is key = value.
#
# Example Call(s):
#
#     With default format of 'key = value':
#     replace_or_append '/etc/sysctl.conf' '^kernel.randomize_va_space' '2' '@CCENUM@'
#
#     With custom key/value format:
#     replace_or_append '/etc/sysconfig/selinux' '^SELINUX=' 'disabled' '@CCENUM@' '%s=%s'
#
#     With a variable:
#     replace_or_append '/etc/sysconfig/selinux' '^SELINUX=' $var_selinux_state '@CCENUM@' '%s=%s'
#
function replace_or_append {
  local default_format='%s = %s' case_insensitive_mode=yes sed_case_insensitive_option='' grep_case_insensitive_option=''
  local config_file=$1
  local key=$2
  local value=$3
  local cce=$4
  local format=$5

  if [ "$case_insensitive_mode" = yes ]; then
    sed_case_insensitive_option="i"
    grep_case_insensitive_option="-i"
  fi
  [ -n "$format" ] || format="$default_format"
  # Check sanity of the input
  [ $# -ge "3" ] || { echo "Usage: replace_or_append <config_file_location> <key_to_search> <new_value> [<CCE number or literal '@CCENUM@' if unknown>] [printf-like format, default is '$default_format']" >&2; exit 1; }

  # Test if the config_file is a symbolic link. If so, use --follow-symlinks with sed.
  # Otherwise, regular sed command will do.
  sed_command=('sed' '-i')
  if test -L "$config_file"; then
    sed_command+=('--follow-symlinks')
  fi

  # Test that the cce arg is not empty or does not equal @CCENUM@.
  # If @CCENUM@ exists, it means that there is no CCE assigned.
  if [ -n "$cce" ] && [ "$cce" != '@CCENUM@' ]; then
    cce="CCE-${cce}"
  else
    cce="CCE"
  fi

  # Strip any search characters in the key arg so that the key can be replaced without
  # adding any search characters to the config file.
  stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "$key")

  # shellcheck disable=SC2059
  printf -v formatted_output "$format" "$stripped_key" "$value"

  # If the key exists, change it. Otherwise, add it to the config_file.
  # We search for the key string followed by a word boundary (matched by \>),
  # so if we search for 'setting', 'setting2' won't match.
  if LC_ALL=C grep -q -m 1 $grep_case_insensitive_option -e "${key}\\>" "$config_file"; then
    "${sed_command[@]}" "s/${key}\\>.*/$formatted_output/g$sed_case_insensitive_option" "$config_file"
  else
    # \n is precaution for case where file ends without trailing newline
    printf '\n# Per %s: Set %s in %s\n' "$cce" "$formatted_output" "$config_file" >> "$config_file"
    printf '%s\n' "$formatted_output" >> "$config_file"
  fi
}

replace_or_append '/etc/login.defs' '^FAIL_DELAY' "$var_accounts_fail_delay" 'CCE-80352-8' '%s %s'
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_logon_fail_delay'

###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_accounts_tmout'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_accounts_tmout'")

var_accounts_tmout="600"

if grep --silent ^TMOUT /etc/profile ; then
        sed -i "s/^TMOUT.*/TMOUT=$var_accounts_tmout/g" /etc/profile
else
        echo -e "\n# Set TMOUT to $var_accounts_tmout per security requirements" >> /etc/profile
        echo "TMOUT=$var_accounts_tmout" >> /etc/profile
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_tmout'

###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_accounts_max_concurrent_login_sessions'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_accounts_max_concurrent_login_sessions'")

var_accounts_max_concurrent_login_sessions="10"

if grep -q '^[^#]*\<maxlogins\>' /etc/security/limits.d/*.conf; then
	sed -i "/^[^#]*\<maxlogins\>/ s/maxlogins.*/maxlogins $var_accounts_max_concurrent_login_sessions/" /etc/security/limits.d/*.conf
elif grep -q '^[^#]*\<maxlogins\>' /etc/security/limits.conf; then
	sed -i "/^[^#]*\<maxlogins\>/ s/maxlogins.*/maxlogins $var_accounts_max_concurrent_login_sessions/" /etc/security/limits.conf
else
	echo "*	hard	maxlogins	$var_accounts_max_concurrent_login_sessions" >> /etc/security/limits.conf
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_max_concurrent_login_sessions'

###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_banner_etc_issue'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_banner_etc_issue'")

login_banner_text="^(You[\s\n]+are[\s\n]+accessing[\s\n]+a[\s\n]+U.S.[\s\n]+Government[\s\n]+\(USG\)[\s\n]+Information[\s\n]+System[\s\n]+\(IS\)[\s\n]+that[\s\n]+is[\s\n]+provided[\s\n]+for[\s\n]+USG-authorized[\s\n]+use[\s\n]+only.[\s\n]*By[\s\n]+using[\s\n]+this[\s\n]+IS[\s\n]+\(which[\s\n]+includes[\s\n]+any[\s\n]+device[\s\n]+attached[\s\n]+to[\s\n]+this[\s\n]+IS\),[\s\n]+you[\s\n]+consent[\s\n]+to[\s\n]+the[\s\n]+following[\s\n]+conditions\:(\\n)*(\n)*-[\s\n]*The[\s\n]+USG[\s\n]+routinely[\s\n]+intercepts[\s\n]+and[\s\n]+monitors[\s\n]+communications[\s\n]+on[\s\n]+this[\s\n]+IS[\s\n]+for[\s\n]+purposes[\s\n]+including,[\s\n]+but[\s\n]+not[\s\n]+limited[\s\n]+to,[\s\n]+penetration[\s\n]+testing,[\s\n]+COMSEC[\s\n]+monitoring,[\s\n]+network[\s\n]+operations[\s\n]+and[\s\n]+defense,[\s\n]+personnel[\s\n]+misconduct[\s\n]+\(PM\),[\s\n]+law[\s\n]+enforcement[\s\n]+\(LE\),[\s\n]+and[\s\n]+counterintelligence[\s\n]+\(CI\)[\s\n]+investigations.(\\n)*(\n)*-[\s\n]*At[\s\n]+any[\s\n]+time,[\s\n]+the[\s\n]+USG[\s\n]+may[\s\n]+inspect[\s\n]+and[\s\n]+seize[\s\n]+data[\s\n]+stored[\s\n]+on[\s\n]+this[\s\n]+IS.(\\n)*(\n)*-[\s\n]*Communications[\s\n]+using,[\s\n]+or[\s\n]+data[\s\n]+stored[\s\n]+on,[\s\n]+this[\s\n]+IS[\s\n]+are[\s\n]+not[\s\n]+private,[\s\n]+are[\s\n]+subject[\s\n]+to[\s\n]+routine[\s\n]+monitoring,[\s\n]+interception,[\s\n]+and[\s\n]+search,[\s\n]+and[\s\n]+may[\s\n]+be[\s\n]+disclosed[\s\n]+or[\s\n]+used[\s\n]+for[\s\n]+any[\s\n]+USG-authorized[\s\n]+purpose.(\\n)*(\n)*-[\s\n]*This[\s\n]+IS[\s\n]+includes[\s\n]+security[\s\n]+measures[\s\n]+\(e.g.,[\s\n]+authentication[\s\n]+and[\s\n]+access[\s\n]+controls\)[\s\n]+to[\s\n]+protect[\s\n]+USG[\s\n]+interests--not[\s\n]+for[\s\n]+your[\s\n]+personal[\s\n]+benefit[\s\n]+or[\s\n]+privacy.(\\n)*(\n)*-[\s\n]*Notwithstanding[\s\n]+the[\s\n]+above,[\s\n]+using[\s\n]+this[\s\n]+IS[\s\n]+does[\s\n]+not[\s\n]+constitute[\s\n]+consent[\s\n]+to[\s\n]+PM,[\s\n]+LE[\s\n]+or[\s\n]+CI[\s\n]+investigative[\s\n]+searching[\s\n]+or[\s\n]+monitoring[\s\n]+of[\s\n]+the[\s\n]+content[\s\n]+of[\s\n]+privileged[\s\n]+communications,[\s\n]+or[\s\n]+work[\s\n]+product,[\s\n]+related[\s\n]+to[\s\n]+personal[\s\n]+representation[\s\n]+or[\s\n]+services[\s\n]+by[\s\n]+attorneys,[\s\n]+psychotherapists,[\s\n]+or[\s\n]+clergy,[\s\n]+and[\s\n]+their[\s\n]+assistants.[\s\n]+Such[\s\n]+communications[\s\n]+and[\s\n]+work[\s\n]+product[\s\n]+are[\s\n]+private[\s\n]+and[\s\n]+confidential.[\s\n]+See[\s\n]+User[\s\n]+Agreement[\s\n]+for[\s\n]+details.|I\'ve[\s\n]+read[\s\n]+\&[\s\n]+consent[\s\n]+to[\s\n]+terms[\s\n]+in[\s\n]+IS[\s\n]+user[\s\n]+agreem\'t$)"

# There was a regular-expression matching various banners, needs to be expanded
# When there are multiple banners in login_banner_text, the first banner should be the one for RHEL7
expanded=$(echo "$login_banner_text" | sed 's/(\\\\\x27)\*/\\\x27/g;s/(\\\x27)\*//g;s/\^(\(.*\)|.*$/\1/g;s/\[\\s\\n\][+*]/ /g;s/\\//g;s/[^-]- /\n\n-/g;s/(n)\**//g')
formatted=$(echo "$expanded" | fold -sw 80)

cat <<EOF >/etc/issue
$formatted
EOF

printf "\n" >> /etc/issue
# END fix for 'xccdf_org.ssgproject.content_rule_banner_etc_issue'



###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_rpm_verify_permissions'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_rpm_verify_permissions'")

# Declare array to hold list of RPM packages we need to correct permissions for
declare -a SETPERMS_RPM_LIST

# Create a list of files on the system having permissions different from what
# is expected by the RPM database
FILES_WITH_INCORRECT_PERMS=($(rpm -Va --nofiledigest | grep '^.M' | cut -d ' ' -f4-))

# For each file path from that list:
# * Determine the RPM package the file path is shipped by,
# * Include it into SETPERMS_RPM_LIST array

for FILE_PATH in "${FILES_WITH_INCORRECT_PERMS[@]}"
do
	RPM_PACKAGE=$(rpm -qf "$FILE_PATH")
	SETPERMS_RPM_LIST=("${SETPERMS_RPM_LIST[@]}" "$RPM_PACKAGE")
done

# Remove duplicate mention of same RPM in $SETPERMS_RPM_LIST (if any)
SETPERMS_RPM_LIST=( $(echo "${SETPERMS_RPM_LIST[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ') )

# For each of the RPM packages left in the list -- reset its permissions to the
# correct values
for RPM_PACKAGE in "${SETPERMS_RPM_LIST[@]}"
do
	rpm --quiet --setperms "${RPM_PACKAGE}"
done
# END fix for 'xccdf_org.ssgproject.content_rule_rpm_verify_permissions'


###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_clean_components_post_updating'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_clean_components_post_updating'")

if grep --silent ^clean_requirements_on_remove /etc/yum.conf ; then
        sed -i "s/^clean_requirements_on_remove.*/clean_requirements_on_remove=1/g" /etc/yum.conf
else
        echo -e "\n# Set clean_requirements_on_remove to 1 per security requirements" >> /etc/yum.conf
        echo "clean_requirements_on_remove=1" >> /etc/yum.conf
fi
# END fix for 'xccdf_org.ssgproject.content_rule_clean_components_post_updating'

###############################################################################
# BEGIN fix for 'xccdf_org.ssgproject.content_rule_ensure_gpgcheck_local_packages'
###############################################################################
(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_ensure_gpgcheck_local_packages'")

if grep --silent ^localpkg_gpgcheck /etc/yum.conf ; then
        sed -i "s/^localpkg_gpgcheck.*/localpkg_gpgcheck=1/g" /etc/yum.conf
else
        echo -e "\n# Set localpkg_gpgcheck to 1 per security requirements" >> /etc/yum.conf
        echo "localpkg_gpgcheck=1" >> /etc/yum.conf
fi
# END fix for 'xccdf_org.ssgproject.content_rule_ensure_gpgcheck_local_packages'

###############################################################################
# BEGIN fix for 'clean yum cache'
###############################################################################
(>&2 echo "Remediating: 'clean cache'")
rm -rf /var/cache/yum/*
