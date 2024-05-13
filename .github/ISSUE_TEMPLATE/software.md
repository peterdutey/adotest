name: Software
description: "Software component"
labels: ["software-component"]
body:
  - type: dropdown
    id: risk-class
    attributes:
      label: Risk class
      description: What is risk classification of the software component?
      options:
        - Unknown
        - Low
        - Medium
        - High
    validations:
      required: true
  - type: textarea
    id: tested-by
    attributes:
      label: Tested by
      description: Enter the Test Case GitHub issue numbers which validate this software component
      placeholder: "#1"
