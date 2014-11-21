import numpy as np

def PseudoPSSM(M):
	#Pseudo-PSSM code as described in Nanni, Lumini, and Brahnam (2014)
	###Inputs###
    # M: Nx20 array (matrix) to extract features from
    ###Outputs###
    # PP: 1-D feature array with 320 values

    N = np.shape(M)[0]
    E = (M - np.mean(M,1).reshape(N,1))/np.std(M,1).reshape(N,1)
    PP = np.zeros((320,1))
    PP[:20,0] = np.mean(E,0)
    print PP

    for lag in range(1,16):
    	PP[lag*20:(lag+1)*20,0] = np.mean((E[:N-lag,:]-E[lag:N,:])**2,0)

    return PP



def AverageBlocks(M):
	#Average Blocks as described in Nanni, Lumini, and Brahnam (2014)
	###Inputs###
    # M: Nx20 array (matrix) to extract features from
    ###Outputs###
    # AB: 1-D feature array with 400 values
	N=np.shape(M)[0]
	AB=np.zeros((20,20))
	for i in range(20):
		AB[i,:]=np.mean(M[round(i*N/20.):min(N,round((i+1)*N/20.)),:],0)
	return AB.reshape(400,1)

# def SVD(M):

# def DCT(M):

# def AutoCovar(M):





M=np.random.randn(100,20)
# featvec=PseudoPSSM(M)
featvec=AverageBlocks(M)
print featvec