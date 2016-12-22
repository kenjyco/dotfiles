battery() {
    date | tee -a ~/acpi-output.log && acpi | tee -a ~/acpi-output.log
}
