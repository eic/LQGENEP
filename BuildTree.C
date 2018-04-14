int BuildTree()
{

  //Creats EIC tree from pythia txt file output
  
//std::string inputFile = "TestOut_all_"+seed+"seed.txt";
  std::string inputFile = "LQGENEP_output.txt";
  std::string outdir = "./";
  
  int events = 1000;
  
  gSystem->Load("libeicsmear");
  BuildTree(inputFile.c_str(), outdir.c_str(), events);
  cout << "********************************************" << endl;
  cout << "File: " << inputFile << " processed in directory " << outdir << endl;

	return 0;
}
