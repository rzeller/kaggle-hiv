import numpy as np
import matplotlib.pyplot as plt

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

def DiscreteCosineTransform(M):
	#Discrete Cosine Transform retaining first 20 coefficients for each amino acid
	###Inputs###
    # M: Nx20 array (matrix) to extract features from
    ###Outputs###
    # DCT: 1-D feature array with 400 values
    from scipy.fftpack import dct
    DCT=dct(M)[:20,:].reshape(400,1)
    return DCT


def AutoCovariance(M):
	#One-sided autocovariance with lags 1 through 15 
	###Inputs###
    # M: Nx20 array (matrix) to extract features from
    ###Outputs###
    # AC: 1-D feature array with 300 values
    Mp=M-np.mean(M,0).reshape(1,20)
    AC=np.zeros((15,20))
    for lag in range(1,16):
    	AC[lag-1,:]=np.mean(Mp[:-lag,:]*Mp[lag:,:],0)
    return AC.reshape(300,1)

def SingularValueDecomposition(M):
	#Singular values based on singular value decomposition
	###Inputs###
    # M: Nx20 array (matrix) to extract features from
    ###Outputs###
    # SVD: 1-D feature array with min(N,20) values
    SVD=np.linalg.svd(M,compute_uv=0)
    return SVD.reshape(len(SVD),1)



M=np.cumsum(np.random.randn(100,20),0)
# featvec=PseudoPSSM(M)
featvec=SingularValueDecomposition(M)
print featvec


# plt.plot(featvec.reshape(15,20))
# plt.show()