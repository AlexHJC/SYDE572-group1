import numpy as np
from scipy.signal import convolve2d


def parzen(data, res, win=10):
    """
    Computes 2D density estimates via Parzen windows.

    Parameters
    ----------
    data : ndarray
        Two-column matrix of (x, y) points. An optional third
        row/column may be used to specify point frequency.
    res : float or array-like
        Resolution (step size) of grid. May optionally specify grid
        boundaries as an array-like: [res xmin ymin xmax ymax].
    win : int or ndarray, optional
        Specifies form of window kernel. Default is 10.
        If an integer -> size of square kernel
        If a vector   -> radially symmetric kernel
        If a matrix   -> used as kernel directly

    Returns
    -------
    p : ndarray
        Estimated 2D PDF.
    x : ndarray
        Locations along x-axis.
    y : ndarray
        Locations along y-axis.
    """
    # Check data shape and augment with ones if required
    if data.shape[1] > data.shape[0]:
        data = data.T
    if data.shape[1] == 2:
        data = np.concatenate([data, np.ones((data.shape[0], 1))], axis=1)
    num_pts = data[:, 2].sum()

    # Get grid resolution and bounds
    res = np.asarray(res)
    if res.ndim:
        dl = res[1:3]
        dh = res[3:]
        res = res[0]
    else:
        dl = data[:, :2].min(axis=0) - res
        dh = data[:, :2].max(axis=0) + res
    if max(dh - dl)/res > 1000:
        raise ValueError('Excessive data range relative to resolution.')

    # Create window if necessary
    if isinstance(win, int):
        win = np.ones((win, win))
    elif win.ndim == 1 or min(win.shape) == 1:
        win = win.ravel()
        win = np.outer(win, win)
    win = win/(res*res*win.sum())

    # Eliminate points outside of the bounds
    in_bounds = (data[:, 0] > dl[0]) & (data[:, 0] < dh[0]) & (data[:, 1] > dl[1]) & (data[:, 1] < dh[1])
    data = data[in_bounds]

    # Populate p matrix - essentially add 1 to the matrix at each point's location
    p = np.zeros((2 + int(round((dh[1] - dl[1])/res)), 2 + int(round((dh[0] - dl[0])/res))))
    for i in range(data.shape[0]):
        j1 = int(round((data[i, 0] - dl[0])/res))
        j2 = int(round((data[i, 1] - dl[1])/res))
        p[j2, j1] += data[i, 2]

    # Convolve with window kernel
    p = convolve2d(p, win, 'same')/num_pts
    x = dl[0] + res*np.arange(p.shape[1])
    y = dl[1] + res*np.arange(p.shape[0])

    return p, x, y
