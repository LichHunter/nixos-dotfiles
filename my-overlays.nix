#this should be temporary as for now default jdk is 21 and it deprecated source 7
self: super: {
  async-profiler = super.async-profiler.override {jdk=super.jdk19;};
}
