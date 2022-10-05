folder('Tools') {
    description('Folder for miscellaneous tools.')
}

freeStyleJob('Tools/clone-repository') {
    parameters {
        stringParam('GIT_REPOSITORY_URL', null, 'Git URL of the repository to clone')
    }
    wrappers {
        preBuildCleanup()
    }
    steps {
        shell('git clone $GIT_REPOSITORY_URL')
    }
}

freeStyleJob('Tools/SEED') {
    parameters {
        stringParam('GITHUB_NAME', null, 'GitHub repository owner/repo_name (e.g.: "EpitechIT31000/chocolatine")')
        stringParam('DISPLAY_NAME', null, 'Display name for the job')
    }
    steps {
        dsl {
            text('''job("$DISPLAY_NAME") {
                scm {
                    git {
                        remote {
                            github("$GITHUB_NAME", 'ssh')
                            credentials('git_ssh_key')
                            branch('master')
                        }
                    }
                }
                wrappers {
                    preBuildCleanup()
                }
                triggers {
                    pollSCM {
                        scmpoll_spec('* * * * *')
                    }
                }
                steps {
                    shell('make fclean')
                    shell('make')
                    shell('make tests_run')
                    shell('make clean')
                }
            }''')
        }
    }
}