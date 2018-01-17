int Distill_pi(string seed)
{
  
  	std::string inputFile = "TestOut_hadronic_"+seed+"seed.txt";
	std::ifstream fin(inputFile.c_str());
	std::string str;

	std::string foutname = "LQ_3pion_"+seed+"seed.txt";
	std::ofstream fout;
	fout.open(foutname.c_str());

	int I, KS, KF, ORIG;
	const int tau_KF = 15;
	const int pi_KF = 211;
	int I_prev = 0;
	int event_count = 0;
	int pi_num = 0;

	vector<int> is_three_pi;
	vector<int> tau_orig;			

	fin.clear();
        fin.seekg(0, ios::beg);

	
	while (std::getline(fin, str))
	  {
	    if(str.length() == 127)
	      {
		//                    cout << str << endl;                                                                                                                                                
		std::istringstream iss(str);
		
		//Read in variables in event
		if(iss >> I >> KS >> KF >> ORIG)
		  {
		    //Reset tau daughters if new event
		    if(I < I_prev) tau_orig.clear();
		    I_prev = I;

		    if(TMath::Abs(KF) == tau_KF){
			//Put tau particle in array
			tau_orig.push_back(I);  
		    }
		    else
		      {
			for(int i = 0; i < tau_orig.size(); i++)
			  {
			    //If daughter from tau
			    if(ORIG == tau_orig[i])
			      {
				
				//add up number of pions
				if(TMath::Abs(KF) == pi_KF){
				  pi_num++;
				}
				//Add particle to daughters from tau
				tau_orig.push_back(I);
			      }
			  }
		      }
		  }
	      }	  
	    else
	      {
		//End of the event
		if(str.find("Event finished") != std::string::npos) {
		  //Store if this event was a three pion event

		  if(pi_num == 3) is_three_pi.push_back(1);
		  else {
		   is_three_pi.push_back(0);
		  }
		  event_count++;
		  if(event_count % 100==0) cout<<event_count<<endl;

		  //Reset pion counter
		  pi_num = 0;
		}
	      }
	  }
	

	int events_left = 0;
	int line_count = 0;
	fin.clear();
	fin.seekg(0, ios::beg);
	
	event_count = 0;
	while (std::getline(fin, str))
          {
	    line_count++;
	    if(line_count<7 && is_three_pi[event_count]==0) fout << str << endl;                                                                                                                                             
	    
            if(str.length() == 127)
              {
		if(is_three_pi[event_count] == 1) fout << str << endl;                                                                                                                                             
		/*		   
		std::istringstream iss(str);
	
                if(iss >> I >> KS >> KF >> ORIG)
                  {
                    if(I < I_prev) tau_orig.clear();
                    I_prev = I;

                    if(I < 3)
                      {
			if(is_three_pi[event_count] == 1) fout << str << endl;
                      }
                    else if(KS == 21)
                      { if(is_three_pi[event_count] == 1) fout << str << endl; }
                    else if(TMath::Abs(KF) == tau_KF)
                      {
			if(is_three_pi[event_count] == 1) fout << str << endl;
			tau_orig.push_back(I);
                      }
                    else
                      {
                        for(int i = 0; i < tau_orig.size(); i++)
                          {
                            if(ORIG == tau_orig[i])
                              {
				if(is_three_pi[event_count] == 1)   fout << str << endl;
				tau_orig.push_back(I);
                              }
                          }
                      }

                  }
		*/
	      }
            else
              {

		if(is_three_pi[event_count]) fout<<str<<endl;

		if(str.find("Event finished") != std::string::npos) {
		  if(is_three_pi[event_count] == 1) {
		    events_left++;
		  }
		  event_count++;
		  if(event_count % 100==0) cout<<event_count<<endl;
		  
		  if(events_left == 1000) break;
		}
              }
	  }


	gSystem->Load("libeicsmear");
       	BuildTree(foutname.c_str(),"./",events_left);

	return 0;
}
