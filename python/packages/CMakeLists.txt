if(ISCE3_WITH_CYTHON)
##isce3 package
file(COPY isce3
     DESTINATION ${ISCE_BUILDPACKAGESDIR})
install(DIRECTORY isce3
        DESTINATION ${ISCE_PACKAGESDIR})

##nisar package
file(COPY nisar
     DESTINATION ${ISCE_BUILDPACKAGESDIR})
install(
    DIRECTORY nisar
    DESTINATION ${ISCE_PACKAGESDIR})
endif()

##pybind nisar package
file(COPY pybind_nisar
     DESTINATION ${ISCE_BUILDPACKAGESDIR})
install(
    DIRECTORY pybind_nisar
    DESTINATION ${ISCE_PACKAGESDIR})

##symlink defaults and schemas from install/share to pybind nisar workflows
set(WORKFLOWS
  defaults
  schemas
)
foreach(WORKFLOW ${WORKFLOWS})
    install(DIRECTORY ${PROJECT_SOURCE_DIR}/share/nisar/${WORKFLOW}
            DESTINATION ${ISCE_PACKAGESDIR}/pybind_nisar/workflows)
endforeach()


# XXX Make RSLC workflow script executable.
install(
    PROGRAMS    pybind_nisar/workflows/focus.py
    DESTINATION ${ISCE_PACKAGESDIR}
    RENAME      pybind_nisar/workflows/focus.py
    )
