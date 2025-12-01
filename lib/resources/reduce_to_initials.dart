String reduceToInitials(String input) {
  return input.split(' ').map((word) => word[0]).join();
}